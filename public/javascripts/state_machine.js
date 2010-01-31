/*
 * Transitions are tuples defined as
 *    - eventName
 *    - initialState
 *    - nextState
 *    - condition
 * 'nextState' may be either a single string or an array of strings,
 * depending on existence of a condition function.
 * The condition returns an integer, which corresponds to the index
 * of the next state string. The condition function accepts one argument
 * (that is, the input hash of the transition event)
 *
 * States are defined as
 *    - name
 *    - localFunction
 */
function StateMachine(states, transitions) {
  this.currentState = null ;
  this.transitions = transitions ;
  this.states = states ;
}

StateMachine.prototype.initialize = function(observedObject, initialStateName, input) {
  this.observed = observedObject ;
  var state = this.states.find(function(el) {
    return el.name == initialStateName ;    
  }) ;
  if (state) {
    console.log(state.name) ;
    this.currentState = state.name ;
    state.localFunction.call(observedObject, input) ;
  }
}

StateMachine.prototype.next = function(eventName, input) {
  var cur_state = this.currentState ;
  var trans = this.transitions.find(function(el) {
      return el.initialState == cur_state &&
        el.eventName == eventName ;
  }) ;
  if (trans) {
    var next_state = undefined ;
    // If there is a condition function, then we need to
    // determine which next state to execute
    if (trans.condition) {
      console.log("Indirect transition!") ;
      var index = trans.condition.call(this, input) ;
      next_state = trans.nextState[index] ;
    } else { // The next state is determined
        console.log("Direct transition!") ;
        next_state = this.states.find(function(el){
        return el.name == trans.nextState ;    
      }) ;
    }
    // We may finally execute the next state
    if (next_state) {
      this.currentState = next_state.name ;
      next_state.localFunction.call(this.observed, input) ;
    }
  } else {
    console.log("No transition was found :(") ;
  }
}
