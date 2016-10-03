angular
  .module 'lunchie'
  .controller 'OrderCtrl', ($scope, $q, Order, Restaurant) ->
    Restaurant.query (restaurants) ->
      $scope.restaurants = restaurants

    $scope.order = {}

    $scope.restaurantSearchTerm = ''
    $scope.restaurantSelected = null

    $scope.filterRestaurants = (searchTerm) ->
      result = $q.defer()
      result.resolve [{ name: searchTerm }]
      result.promise

    return
