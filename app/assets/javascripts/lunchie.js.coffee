@lunchie = angular.module 'lunchie', [
  'ui.router',
  'templates',
  'ngMaterial',
  'ng-token-auth',
  'ngResource',
  'ngMessages'
]

@lunchie.config [
  '$stateProvider',
  '$urlRouterProvider',
  '$authProvider',
  '$mdThemingProvider',
  '$resourceProvider',
  ($stateProvider, $urlRouterProvider, $authProvider, $resourceProvider) ->
    # $resourceProvider.defaults.actions.get.responseType = 'json'
    # $resourceProvider.defaults.actions.save.responseType = 'json'
    # $resourceProvider.defaults.actions.query.responseType = 'json'
    # $resourceProvider.defaults.actions.delete.responseType = 'json'

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

    userProfileState =
      name: 'profile'
      url: '/user/profile'
      templateUrl: 'user/show.html'

    ordersState =
      name: 'orders'
      url: '/orders'
      abstract: true
      template: '<div ui-view=""></div>'

    newOrderState =
      parent: 'orders'
      name: 'new_order'
      url: '/new'
      templateUrl: 'orders/new.html'
      controller: 'OrderCtrl'

    $stateProvider.state signUpState
    $stateProvider.state signInState
    $stateProvider.state homeState
    $stateProvider.state userProfileState
    $stateProvider.state ordersState
    $stateProvider.state newOrderState

    $urlRouterProvider.otherwise '/'
    return
]
