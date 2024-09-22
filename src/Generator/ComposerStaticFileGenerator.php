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

class ComposerStaticFileGenerator extends StaticFileGenerator
{
    public function generate(): void
    {
        $values = (array)$this->twigValues;
        $values['nameSpace'] = str_replace('\\', '\\\\', $values['nameSpace']);
        $code = $this->twig
            ->render(
                '@Modules'
                .$this->templatesBaseFolder
                .DIRECTORY_SEPARATOR
                .$this->templateName,
                $values
            );

        $moduleFolder = $this->getModuleFolder();
        $fileNameModule = $this->getFileNameModule();

        $this->filesystem->dumpFile($moduleFolder.$fileNameModule, $code);
    }
}