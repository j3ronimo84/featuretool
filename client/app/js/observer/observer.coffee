makeObservable = (object, prototype = Observer.prototype) ->
	extend object, prototype
	object.subscribers = {}

class Observer
	debugMode: false
	constructor: ->
		@subscribers = {}
		if window["anev"]?
			@debugMode = window["anev"].debugMode
	on: (type, fn, context) ->
		if typeof  fn isnt "function"
			if typeof context[fn] is "function"
				fn = context[fn]
			else
				throw new Error "None of variables #{fn}, #{context[fn]} are functions"
		if typeof @subscribers[type] is "undefined"
			@subscribers[type] = []
		@subscribers[type].push fn: fn, context: context || @

	fire: (type) ->
		args = [].slice.call arguments, 1
		if @debugMode then console.log "fire " + type, args, @
		if @subscribers[type]?
			for method, key  in @subscribers[type]
				do (key, method) ->
					method.fn.apply method.context, args

	remove: (type, fn, context) ->
		for method, key  in @subscribers[type] when method.fn is fn and method.context is context
			do (key, method) ->
				@subscribers[type].splice key, 1

	listen: (object, type, fn) ->
		if @debugMode then console.log "listening " + type, object
		object.on type, fn

window.anev = new Observer
window.anev.debugMode = false
