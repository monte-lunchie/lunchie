angular
  .module 'lunchie'
  .controller 'OrdersIndexCtrl', ($scope, Order) ->
    $scope.orders = Order.query()
