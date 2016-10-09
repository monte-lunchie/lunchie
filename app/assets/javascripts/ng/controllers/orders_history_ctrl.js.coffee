angular
  .module 'lunchie'
  .controller 'OrdersHistoryCtrl', ($scope, Order) ->
    $scope.orders = Order.query
      scope: 'historical'

    $scope.filterOrders = (state) ->
      $scope.orders.filter (order) ->
        order.state == state
