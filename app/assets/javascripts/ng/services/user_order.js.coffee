angular
  .module 'lunchie'
  .factory 'UserOrder', ($resource) ->
    $resource "api/user_orders/:id", { id: '@id' }
