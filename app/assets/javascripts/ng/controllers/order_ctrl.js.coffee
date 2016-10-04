angular
  .module 'lunchie'
  .controller 'OrderCtrl', ($scope, $timeout, $q, $mdToast, Order, Restaurant) ->
    createSimpleFilter = (searchTerm) ->
      (restaurant) ->
        name = angular.lowercase restaurant.name
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

    $scope.createOrder = ->
      if $scope.restaurantSelected == null
        $scope.showToastMessage 'No restaurant name provided!'
      else
        order = new Order
          order:
            creator_id: $scope.user.id
            restaurant_attributes: $scope.restaurantSelected

        order.$save()

    return
