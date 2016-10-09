angular
  .module 'lunchie'
  .controller 'OrderShowCtrl', ($scope, $stateParams, Order) ->
    $scope.order = Order.get { id: $stateParams.id }
