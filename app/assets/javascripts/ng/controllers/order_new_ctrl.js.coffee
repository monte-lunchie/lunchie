angular
  .module 'lunchie'
  .controller 'OrderNewCtrl', ($scope, $timeout, $q, $mdToast, $mdDialog, Order, Restaurant) ->
    createSimpleFilter = (searchTerm) ->
      (item) ->
        name = angular.lowercase items.name
        term = angular.lowercase searchTerm

        name.indexOf(term) != -1

    $scope.showToastMessage = (message) ->
      toast = $mdToast.simple()
        .textContent message
        .position 'top right'
        .hideDelay 5000
      $mdToast.show toast

    $scope.restaurants = Restaurant.query()
    $scope.order = {}

    $scope.restaurantSearchTerm = ''
    $scope.restaurantSelected = null

    $scope.filterRestaurants = (searchTerm) ->
      deferred = $q.defer()
      if searchTerm
        results = $scope.restaurants.filter(createSimpleFilter(searchTerm))
        results.push { id: null, name: searchTerm } if results.length == 0
      else
        results = $scope.restaurants

      deferred.resolve(results)
      deferred.promise

    $scope.showNewMealDialog = ($event)->
      if $scope.restaurantSelected == null
        $scope.showToastMessage 'No restaurant name provided!'
      else
        mealDialog = $mdDialog.show
          templateUrl: 'meals/new.html'
          escapeToClose: true
          clickOutsideToClose: true
          openFrom: $event.target
          closeTo: $event.target

    $scope.createOrder = ->
      if $scope.restaurantSelected == null
        $scope.showToastMessage 'No restaurant name provided!'
      else if $scope.mealSelected == null
        $scope.showToastMessage 'No meal provided!'
      else
        order = new Order
          order:
            creator_id: $scope.user.id
            restaurant_attributes: $scope.restaurantSelected

        order.$save()

    return
