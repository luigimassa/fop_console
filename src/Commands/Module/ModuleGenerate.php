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

namespace FOP\Console\Commands\Module;

use FOP\Console\Command;
use FOP\Console\Generator\ClassFileGenerator;
use FOP\Console\Generator\MainModuleFileGenerator;
use FOP\Console\Generator\ContentFileDTO;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\Question;

class ModuleGenerate extends Command
{
    private array $generatorServices = [];
    private string $moduleName;
    private ContentFileDTO $configGeneration;

    public function setGeneratorServices(iterable $services)
    {
        $this->generatorServices = iterator_to_array($services);
    }

    protected function configure(): void
    {
        $this->setName('fop:module:generate')
            ->setDescription('Scaffold module');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $this->twig = $this->getContainer()
            ->get('twig');

        $output->writeln('create module');
        $this->generate($this->moduleName);
    }

    private function generate($moduleName)
    {
        //create module folder
        $filesystem = $this->getContainer()->get('filesystem');
        $filesystem->mkdir(_PS_MODULE_DIR_.$moduleName);
        $filesystem->mkdir(_PS_MODULE_DIR_.$moduleName.'/config');
        $filesystem->mkdir(_PS_MODULE_DIR_.$moduleName.'/src');
        $filesystem->mkdir(_PS_MODULE_DIR_.$moduleName.'/tests');
        foreach ($this->generatorServices as $serviceGenerator) {
            $serviceGenerator->setModuleName($this->moduleName);
            $serviceGenerator->setTwigValues($this->configGeneration);
            if ($serviceGenerator instanceof MainModuleFileGenerator) {
                $serviceGenerator->setModuleFolder($this->moduleName);
                $serviceGenerator->setFileNameModule('.php');
            }
            $serviceGenerator->generate();
        }
    }

    protected function interact(InputInterface $input, OutputInterface $output)
    {
        $this->configGeneration = new ContentFileDTO();
        $helper = $this->getHelper('question');

        $ask_module_name = new Question(
            'Please enter the module name: ',
        );

        $this->moduleName = $helper->ask($input, $output, $ask_module_name);

        $this->configGeneration->nameSpace = $helper->ask(
            $input,
            $output,
            new Question(
                'Please enter the name space: ',
            )
        );

        $this->configGeneration->moduleName = $this->moduleName;

        $this->configGeneration->className = Ucfirst($this->configGeneration->moduleName);
        $this->configGeneration->serviceName = strtolower($this->configGeneration->className);


        if (file_exists(_PS_MODULE_DIR_.$this->moduleName) === true) {
            throw new \Exception('Module already exists');
        }
    }
}
