# dP     dP                          dP                  
# 88     88                          88                  
# 88aaaaa88a .d8888b. .d8888b. .d888b88 .d8888b. 88d888b.
# 88     88  88ooood8 88'  `88 88'  `88 88ooood8 88'  `88
# 88     88  88.  ... 88.  .88 88.  .88 88.  ... 88      
# dP     dP  `88888P' `88888P8 `88888P8 `88888P' dP    

Type = require 'md-components/Type'
{ Ripple } = require 'md-components/Ripple'
{ Icon } = require 'md-components/Icon'
{ Theme } = require 'md-components/Theme'
{ StatusBar } = require 'md-components/StatusBar'

exports.Header = class Header extends Layer
	constructor: (options = {}) ->
		
		@_title = undefined
		@_icon = undefined
		@_iconAction = options.iconAction ? -> null

		super _.defaults options,
			name: 'Header', 
			width: Screen.width, height: 80
			shadowY: 2, shadowBlur: 3, shadowColor: 'rgba(0,0,0,.24)'
			backgroundColor: Theme.header.backgroundColor

		# TODO: if options.icon is false then no iconLayer, move title left

		@titleLayer = new Type.Title
			name: '.', parent: @
			x: 72, y: Align.bottom(-14)
			color: Theme.header.title
			text: @title ? "No title"

		@title = options.title ? 'Default Header'

		@iconLayer = new Icon
			name: '.', parent: @, 
			x: 12, y: Align.center(12)
			icon: 'menu', color: Theme.header.icon.color

		@icon = options.icon ? 'menu'

		@statusBar = new StatusBar
			name: '.', parent: @

		@iconLayer.onTap => @_iconAction()
		@iconLayer.onTouchStart (event) => Ripple(@, event.point, @titleLayer)


	@define "title",
		get: -> return @_title
		set: (titleText) ->
			@_title = titleText
			@titleLayer.textReplace(@titleLayer.text, @_title)

	@define "icon",
		get: -> return @_icon
		set: (iconName) -> 
			@_icon = iconName
			@iconLayer.icon = iconName

	@define "iconColor",
		get: -> return @_icon.color
		set: (color) -> 
			@iconLayer.color = color

	@define "iconAction",
		get: -> return @_iconAction
		set: (action) ->
			@_iconAction = action