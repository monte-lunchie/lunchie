angular
  .module 'lunchie'
  .controller 'OrderCtrl', ($scope, $timeout, $q, Order, Restaurant) ->
    createSimpleFilter = (searchTerm) ->
      (restaurant) ->
        name = angular.lowercase restaurant.name
        term = angular.lowercase searchTerm

        name.indexOf(term) != -1

    $scope.restaurants = Restaurant.query()
    $scope.order = {}

    $scope.restaurantSearchTerm = ''
    $scope.restaurantSelected = null

    $scope.filterRestaurants = (searchTerm) ->
      deferred = $q.defer()
      if searchTerm
        results = $scope.restaurants.filter(createSimpleFilter(searchTerm))
        results.push { name: searchTerm } if results.length == 0
      else
        results = $scope.restaurants

      deferred.resolve(results)
      deferred.promise

    return
