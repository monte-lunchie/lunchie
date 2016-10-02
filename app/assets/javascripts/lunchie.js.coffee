@lunchie = angular.module 'lunchie', ['ui.router', 'templates', 'lunchie.app_ctrl']

@lunchie.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  homeState = 
    name: 'home'
    url: ''
    templateUrl: 'home.html'
    controller: 'AppCtrl'

  $stateProvider.state homeState
  $urlRouterProvider.otherwise ''
  return
]
