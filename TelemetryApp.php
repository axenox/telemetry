<?php
namespace axenox\Telemetry;

use exface\Core\Interfaces\InstallerInterface;
use exface\Core\CommonLogic\Model\App;
use exface\Core\CommonLogic\AppInstallers\MySqlDatabaseInstaller;

/**
 * 
 * @author Andrej Kabachnik
 *
 */
class TelemetryApp extends App
{
    /**
     * 
     * {@inheritDoc}
     * @see \exface\Core\CommonLogic\Model\App::getInstaller()
     */
    public function getInstaller(InstallerInterface $injected_installer = null)
    {
        $container = parent::getInstaller($injected_installer);
        
        $sqlInstaller = new MySqlDatabaseInstaller($this->getSelector());
        $sqlInstaller
            ->setFoldersWithMigrations(['InitDB','Migrations','InitData'])
            ->setFoldersWithStaticSql(['Views'])
            ->setDataSourceSelector('0x11ee8cfe55fd9a648cfe025041000001')        
            ->setMigrationsTableName('_migrations');
        $container->addInstaller($sqlInstaller);
        
        return $container;
    }
}
?>