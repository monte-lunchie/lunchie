angular
  .module 'lunchie'
  .controller 'OrderCtrl', ($scope, $timeout, $q, Order, Restaurant) ->
    createSimpleFilter = (searchTerm) ->
      (restaurant) ->
        restaurant.name.indexOf(searchTerm) != -1

    $scope.restaurants = Restaurant.query()
    $scope.order = {}

    $scope.restaurantSearchTerm = ''
    $scope.restaurantSelected = null

    $scope.filterRestaurants = (searchTerm) ->
      deferred = $q.defer()
      if searchTerm
        results = $scope.restaurants.filter(createSimpleFilter(searchTerm)) && [{ name: searchTerm }]
      else
        results = $scope.restaurants

      $timeout deferred.resolve(results), 300
      deferred.promise

    return
