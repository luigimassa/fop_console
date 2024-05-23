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
 *
 */

namespace FOP\Console\Generator;

class TwigFileGenerator extends FileGenerator
{
    private string $moduleFolder;

    public function generate(): void
    {
        $from = _PS_MODULE_DIR_
            . DIRECTORY_SEPARATOR
            . $this->templatesBaseFolder
            . DIRECTORY_SEPARATOR
            . $this->templateName;

        $this->filesystem->copy(
            $from,
            $this->getModuleFolder() . $this->getFileNameModule()
        );
    }

    public function getFileNameModule(): string
    {
        return DIRECTORY_SEPARATOR . $this->twigValues->serviceName . '_' . parent::getFileNameModule();
    }

    protected function getModuleFolder(): string
    {
        return $this->getModuleDirectory()
            . DIRECTORY_SEPARATOR
            . $this->moduleFolder;
    }

    public function setModuleFolder(string $moduleFolder): void
    {
        $this->moduleFolder = $moduleFolder;
    }
}
