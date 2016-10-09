angular
  .module 'lunchie'
  .factory 'Order', ($resource) ->
    $resource "api/user_orders/:id", { id: '@id' }
