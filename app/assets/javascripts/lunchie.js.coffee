@lunchie = angular.module 'lunchie', [
  'ui.router',
  'templates',
  'ngMaterial',
  'ng-token-auth'
]

@lunchie.config ['$stateProvider', '$urlRouterProvider', '$authProvider', ($stateProvider, $urlRouterProvider, $authProvider) ->
  $authProvider.configure
    apiUrl: '/api'

  signUpState =
    name: 'sign-up'
    url: '/sign_up'
    templateUrl: 'auth/sign_up.html'
    controller: 'AuthCtrl'

  signInState =
    name: 'sign-in'
    url: '/sign_in'
    templateUrl: 'auth/sign_in.html'
    controller: 'AuthCtrl'

  homeState =
    name: 'home'
    url: ''
    templateUrl: 'home.html'
    controller: 'AppCtrl'

  $stateProvider.state signUpState
  $stateProvider.state signInState
  $stateProvider.state homeState

  $urlRouterProvider.otherwise '/'
  return
]
