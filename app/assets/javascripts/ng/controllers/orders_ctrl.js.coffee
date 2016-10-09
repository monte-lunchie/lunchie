angular
  .module 'lunchie'
  .controller 'OrdersCtrl', ($scope, $q, $mdDialog, $mdToast, UserOrder) ->
    $scope.showToastMessage = (message) ->
      toast = $mdToast.simple()
        .textContent message
        .position 'top right'
        .hideDelay 5000
      $mdToast.show toast

    $scope.clearForms = ->
      $scope.mealSearchTerm = ''
      $scope.mealSelected = null
      $scope.mealPrice = 0.0

    $scope.createSimpleFilter = (searchTerm) ->
      (item) ->
        name = angular.lowercase item.name
        term = angular.lowercase searchTerm

        name.indexOf(term) != -1

    $scope.filterMeals = (searchTerm) ->
      deferred = $q.defer()
      if searchTerm && $scope.order && $scope.order.restaurant && $scope.order.restaurant.meals
        results = $scope.order.restaurant.meals.filter($scope.createSimpleFilter(searchTerm))
        results.push { id: null, name: searchTerm } if results.length == 0
      else
        results = [{ id: null, name: searchTerm }]

      deferred.resolve(results)
      deferred.promise

    $scope.canJoinOrder = (user, order) ->
      if order and order.hasOwnProperty('user_orders')
        index = order.user_orders.findIndex (user_order) ->
          user_order.user.id == user.id

        order.state == "active" and index == -1
      else
        false

    $scope.canFinalizeOrder = (user, order) ->
      order.state == "active"

    $scope.canConfirmOrderPlacement = (user, order) ->
      order.state == "finalized"

    $scope.canConfirmOrderDelivery = (user, order) ->
      order.state == "ordered"

    $scope.showJoinDialog = ($event, order) ->
      $scope.order = order

      if order.restaurant == null
        $scope.showToastMessage 'No restaurant provided!'
      else
        $scope.mealSearchTerm = ''
        $scope.mealSelected = null
        $scope.mealPrice = 0.0
        $mdDialog.show
          templateUrl: 'meals/new.html'
          escapeToClose: true
          clickOutsideToClose: true
          openFrom: $event.target
          closeTo: $event.target
          scope: $scope
          preserveScope: true

    $scope.showFinalizeDialog = ($event, order) ->
      $scope.order = order

      $mdDialog.show
        templateUrl: 'orders/finalize.html'
        escapeToClose: true
        clickOutsideToClose: true
        openFrom: $event.target
        closeTo: $event.target
        scope: $scope
        preserveScope: true

    $scope.addOrder = ->
      if !($scope.order && $scope.order.restaurant_id)
        $scope.showToastMessage 'No restaurant!'
      else if $scope.mealSelected == null
        $scope.showToastMessage 'No meal provided!'
      else if $scope.mealPrice < 0
        $scope.showToastMessage 'No price provided!'
      else
        user_order = new UserOrder
          user_order:
            user_id: $scope.user.id
            order_id: $scope.order.id
            meal_attributes:
              id: $scope.mealSelected.id
              name: $scope.mealSelected.name
              price: $scope.mealPrice
              restaurant_id: $scope.order.restaurant.id

        user_order.$save (user, response) ->
          $scope.clearForms()
          $mdDialog.hide()
          $scope.showToastMessage 'Order created!'
