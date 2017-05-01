import angular from 'angular';
import %moduleName%Component from './%dashedModuleName%.component';

export default angular
  .module('%moduleName%', [])
  .component('%moduleName%Component', %moduleName%Component)
  .name;
