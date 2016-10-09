angular
  .module 'lunchie'
  .controller 'OrdersIndexCtrl', ($scope, Order) ->
    $scope.orders = Order.query()

    $scope.filterOrders = (state) ->
      $scope.orders.filter (order) ->
        order.state == state
