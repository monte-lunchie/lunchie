angular
  .module 'lunchie'
  .controller 'OrdersCtrl', ($scope, $q, $state, $mdDialog, $mdToast, Order, UserOrder) ->
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

    $scope.setPrice = (meal) ->
      if meal.hasOwnProperty('price')
        $scope.mealPrice = meal.price

    $scope.total = ->
      $scope.order.user_orders.reduce (user_order_a, user_order_b) ->
        user_order_a.meal.price + user_order_b.meal.price

    $scope.stateStyle = (order) ->
      if order.state == "active"
        'default'
      else
        order.state

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

    $scope.showOrderFinalizeDialog = ($event, order) ->
      $scope.order = order

      confirmDialog = $mdDialog.confirm()
      .title 'Are you sure you want to finalize the order?'
      .textContent 'The order state will be set to finalized. No one will be able to add their orders to the list.'
      .theme 'default'
      .targetEvent $event
      .ok 'Finalize it!'
      .cancel 'Cancel'

      $mdDialog.show confirmDialog,
        escapeToClose: true
        clickOutsideToClose: true
      .then ->
        $scope.setOrderState('finalized')

    $scope.showOrderConfirmationDialog = ($event, order) ->
      $scope.order = order

      $mdDialog.show
        templateUrl: 'orders/order.html'
        escapeToClose: true
        clickOutsideToClose: true
        openFrom: $event.target
        closeTo: $event.target
        scope: $scope
        preserveScope: true

    $scope.showOrderDeliveryDialog = ($event, order) ->
      $scope.order = order

      confirmDialog = $mdDialog.confirm()
      .title 'Are you sure you want to set the state to delivered?'
      .textContent 'The order state will be set to delivered. Everyone will see the food has arrived. Be aware.'
      .theme 'default'
      .targetEvent $event
      .ok 'Yes, it\'s here!'
      .cancel 'It\'s not here yet'

      $mdDialog.show confirmDialog,
        escapeToClose: true
        clickOutsideToClose: true
      .then ->
        $scope.setOrderState('delivered')

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

        user_order.$save (order) ->
          $scope.clearForms()
          $mdDialog.hide()
          $state.go $state.current, {}, { reload: true }
          .then ->
            $scope.showToastMessage 'Order created!'

    $scope.setOrderState = (state) ->
      $scope.order.state = state
      Order.update { id: $scope.order.id },
        order:
          id: $scope.order.id
          state: $scope.order.state

    $scope.setOrdered = ->
      $scope.setOrderState 'ordered'
      $mdDialog.hide()
