@lunchie = angular.module 'lunchie', [
  'ui.router',
  'templates',
  'ngMaterial',
  'ng-token-auth'
]

@lunchie.config [
  '$stateProvider',
  '$urlRouterProvider',
  '$authProvider',
  '$mdThemingProvider',
  ($stateProvider, $urlRouterProvider, $authProvider) ->

    $authProvider.configure
      apiUrl: '/api'
      authProviderPaths:
        github: '/auth/github'

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

    userProfileState =
      name: 'profile'
      url: '/user/profile'
      templateUrl: 'user/show.html'

    $stateProvider.state signUpState
    $stateProvider.state signInState
    $stateProvider.state homeState
    $stateProvider.state userProfileState

    $urlRouterProvider.otherwise '/'
    return
]
