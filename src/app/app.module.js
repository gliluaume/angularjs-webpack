import angular from 'angular';
import angularMaterial from 'angular-material';
import appComponent from './app.component';
import appController from './app.controller';
import navbar from './navbar/navbar.module'
import '../style/app.css';

export default angular.module('app', [
  angularMaterial,
  navbar
  ])
  .controller('appController', appController)
  .component('appComponent', appComponent)
  .name;
