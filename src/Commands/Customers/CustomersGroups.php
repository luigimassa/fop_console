<?php
/**
 * Copyright (c) Since 2020 Friends of Presta
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file docs/licenses/LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to infos@friendsofpresta.org so we can send you a copy immediately.
 *
 * @author    Friends of Presta <infos@friendsofpresta.org>
 * @copyright since 2020 Friends of Presta
 * @license   https://opensource.org/licenses/AFL-3.0  Academic Free License ("AFL") v. 3.0
 */

namespace FOP\Console\Commands\Customers;

use Configuration;
use Customer;
use FOP\Console\Command;
use Group;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\ChoiceQuestion;
use Symfony\Component\Console\Question\ConfirmationQuestion;
use Symfony\Component\Console\Style\SymfonyStyle;
use Validate;

/**
 * This command display common information the latest products.
 */
final class CustomersGroups extends Command
{
    public const ACTION_DELETE_FROM_GROUP = 1;
    public const ACTION_REMOVE_CUSTOMERS_TO_FROM_GROUP = 2;
    public const ACTION_JUST_COPY = 3;
    public const ACTION_CANCEL = 4;

    public $groupQuestionsKeyPrefix;
    public $actionQuestionsKeyPrefix;
    public $idLang;
    public $groups = [];
    public $displaySummaryTab = true;

    /**
     * @param string|null $name The name of the command; passing null means it must be set in configure()
     *
     * @throws LogicException When the command name is empty
     */
    public function __construct($name = null)
    {
        parent::__construct($name);

        $this->groupQuestionsKeyPrefix = 'category_';
        $this->actionQuestionsKeyPrefix = 'action_';
        $this->idLang = (int) Configuration::get('PS_LANG_DEFAULT');
        $this->groups = Group::getGroups($this->idLang, false);
    }

    /**
     * {@inheritdoc}
     */
    protected function configure()
    {
        $this
            ->setName('fop:customer-groups')
            ->setDescription('Customer groups')
            ->setHelp('Customer groups')
        ;
    }

    /**
     * {@inheritdoc}
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $helper = $this->getHelper('question');

        $optionsGroupFrom = $this->getQuestionsOptions('optionsGroupFrom');
        $optionsGroupTo = $this->getQuestionsOptions('optionsGroupTo');

        if (count($optionsGroupFrom) <= 1) {
            $output->writeln('<error>You must have at least two groups associated with at least one customer</error>');

            return;
        }

        $questionGroupFrom = new ChoiceQuestion(
            '<question>Please select the group from :</question>',
            $optionsGroupFrom
        );

        $questionGroupFrom->setErrorMessage('Group from %s not found.');

        $groupFrom = $helper->ask($input, $output, $questionGroupFrom);
        $groupFromId = (int) str_replace($this->groupQuestionsKeyPrefix, '', $groupFrom);
        $groupFromName = $this->getGroupName($groupFromId);
        $output->writeln('<info>You have just selected: ' . $groupFromName . '</info>');

        // Remove selected group from in group to list.
        unset($optionsGroupTo[$this->groupQuestionsKeyPrefix . $groupFromId]);

        $questionGroupTo = new ChoiceQuestion(
            '<question>Please select the group to :</question>',
            $optionsGroupTo
        );

        $questionGroupTo->setErrorMessage('Group to %s not found.');

        $groupTo = $helper->ask($input, $output, $questionGroupTo);
        $groupToId = (int) str_replace($this->groupQuestionsKeyPrefix, '', $groupTo);
        $groupToName = $this->getGroupName($groupToId);
        $output->writeln('<info>You have just selected: ' . $groupToName . '</info>');

        $optionsActions = $this->getQuestionsOptions('optionsActions', $groupFromName);

        // Remove delete action when from group as a PS defautl group
        if (in_array((int) $groupFromId, $this->getDefaultPsGroups())) {
            unset($optionsActions[$this->actionQuestionsKeyPrefix . self::ACTION_DELETE_FROM_GROUP]);
        }

        $questionActions = new ChoiceQuestion(
            '<question>After moving the customers from (' . $groupFromName . ') group to (' . $groupToName . ') group </question>',
            $optionsActions
        );

        $questionActions->setErrorMessage('Invalid action %s .');

        $selectedAction = $helper->ask($input, $output, $questionActions);
        $selectedActionId = (int) str_replace($this->actionQuestionsKeyPrefix, '', $selectedAction);
        $output->writeln('<info>You have just selected: ' . $optionsActions[$selectedAction] . '</info>');

        if (self::ACTION_CANCEL === (int) $selectedActionId) {
            $output->writeln('<info>Action canceled</info>');

            return;
        }

        if (!$this->userConfirmation(
            $input,
            $output,
            $groupFromName,
            $groupToName,
            $optionsActions[$selectedAction]
        )) {
            $output->writeln('<info>Action abandoned</info>');

            return;
        }

        $this->groupCustomersTransfer($groupFromId, $groupToId, $selectedActionId, $output);

        if ($this->displaySummaryTab) {
            // Summary  Tab :

            $io = new SymfonyStyle($input, $output);
            $io->title('Customers groups');

            $io->table(
                ['ID', 'Category name', 'Members Nb', 'Reduction (%)'],
                $this->formatGroupsInformations(
                    Group::getGroups($this->idLang, false), // refresh groups to avoid old datas.
                    'table'
                )
            );
        }
    }

    /**
     * @param int $idGroupFrom
     * @param int $IdGroupTo
     * @param int $actionAfter
     * @param OutputInterface $output
     *
     * @return null
     */
    private function groupCustomersTransfer(
        int $idGroupFrom,
        int $IdGroupTo,
        int $actionAfter,
        OutputInterface $output
    ): void {
        $groupFrom = new Group($idGroupFrom);
        $GroupTo = new Group($IdGroupTo);
        $hasError = 0;

        if (!Validate::isLoadedObject($groupFrom)
         || !Validate::isLoadedObject($GroupTo)) {
            $output->writeln('<error>Invalid groups given </error>');

            return;
        }

        $groupFromCustomers = $groupFrom->getCustomers();

        $progress = new ProgressBar($output, count($groupFromCustomers));
        $progress->start();

        foreach ($groupFromCustomers as $k => $v) {
            $customer = new Customer($v['id_customer']);
            $customerGroups = $customer->getGroups();

            switch ((int) $actionAfter) {
                case self::ACTION_JUST_COPY:
                    $customer->addGroups([$GroupTo->id]);
                    continue 2;
                    break;
                case self::ACTION_REMOVE_CUSTOMERS_TO_FROM_GROUP:
                    $customerGroups = array_diff($customerGroups, [$groupFrom->id]); // remove group from
                    break;
            }

            array_push($customerGroups, $GroupTo->id); // add group to

            if ((int) $groupFrom->id == (int) $customer->id_default_group) {
                $customer->id_default_group = (int) $GroupTo->id;
            }

            try {
                $customer->updateGroup($customerGroups);
                $customer->update();
            } catch (\Exception $e) {
                $output->writeln(
                        '<error>
                            An error has occurred when try to update customer ' . $customer->email . ' to group ' . $this->getGroupName($groupFrom->id) . ' : ' . $e->getMessage() .
                        '</error>'
                    );
                ++$hasError;

                return;
            }

            $progress->advance();
        }

        // Delete the form group
        if (self::ACTION_DELETE_FROM_GROUP == (int) $actionAfter && !$hasError) {
            try {
                $groupFrom->delete();
            } catch (\Exception $e) {
                $output->writeln(
                    '<error> 
                        An error has occurred when try to delete group ' . $this->getGroupName($groupFrom->id) . ' : ' . $e->getMessage() .
                    '</error>'
                );

                return;
            }
        }
    }

    /**
     * @param array $groups groups datas
     * @param string $type
     * @param bool $skipEmpty
     *
     * @return array
     */
    private function formatGroupsInformations(array $groups, $type = 'table', $skipEmpty = false): array
    {
        $groupsInformations = [];

        foreach ($groups as $group) {
            $groupObject = new Group((int) $group['id_group']);
            $nb = $groupObject->getCustomers(true);

            if ($nb <= 0 && $skipEmpty) {
                continue;
            }

            if ($type === 'table') {
                $groupsInformations[] = [
                    $groupObject->id,
                    $group['name'],
                    $nb,
                    $groupObject->reduction . ' %',
                ];
            } elseif ($type === 'question') {
                $groupsInformations[$this->groupQuestionsKeyPrefix . $groupObject->id] = $group['name'] . ' (' . $nb . ')';
            }
        }

        return $groupsInformations;
    }

    /**
     * @param int $type
     *
     * @return string
     */
    private function getGroupName(int $idGroup): string
    {
        return (new Group($idGroup, $this->idLang))->name;
    }

    /**
     * @param string $type
     * @param string $groupFromName
     *
     * @return array
     */
    private function getQuestionsOptions(string $type, string $groupFromName = null): array
    {
        $questionsOptions = [
            'optionsGroupFrom' => $this->formatGroupsInformations($this->groups, 'question', true),
            'optionsGroupTo' => $this->formatGroupsInformations($this->groups, 'question', false),
            'optionsActions' => [
                $this->actionQuestionsKeyPrefix . self::ACTION_DELETE_FROM_GROUP => 'Delete (' . $groupFromName . ') group',
                $this->actionQuestionsKeyPrefix . self::ACTION_REMOVE_CUSTOMERS_TO_FROM_GROUP => 'Remove customers in (' . $groupFromName . ') group',
                $this->actionQuestionsKeyPrefix . self::ACTION_JUST_COPY => 'Just add to new group',
                $this->actionQuestionsKeyPrefix . self::ACTION_CANCEL => 'Cancel current action',
            ],
        ];

        return $questionsOptions[$type] ?? [];
    }

    /**
     * user confirmation
     *
     * @param InputInterface $input
     * @param OutputInterface $output
     * @param string $groupFromName
     * @param string $groupToName
     * @param string $selectedActionValue
     *
     * @return bool
     */
    private function userConfirmation(
        InputInterface $input,
        OutputInterface $output,
        string $groupFromName,
        string $groupToName,
        string $selectedActionValue
    ): bool {
        $helper = $this->getHelper('question');

        $questionConfirm = new ConfirmationQuestion(
            '<question>
                This action will move the customers from group (' . $groupFromName . ') into group (' . $groupToName . ') and 
                ' . $selectedActionValue . '. 
                Continue with this action? (Y/N) : 
            </question>',
            false,
            '/^(y|Y)/i'
        );

        return $helper->ask($input, $output, $questionConfirm);
    }

    /**
     * Default Prestashop groups
     *
     * @return array
     */
    private function getDefaultPsGroups(): array
    {
        return [
            (int) Configuration::get('PS_UNIDENTIFIED_GROUP'),
            (int) Configuration::get('PS_GUEST_GROUP'),
            (int) Configuration::get('PS_CUSTOMER_GROUP'),
        ];
    }
}