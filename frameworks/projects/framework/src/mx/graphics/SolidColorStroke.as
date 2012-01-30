////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.graphics
{
 
import flash.display.Graphics;
import flash.events.EventDispatcher;
import flash.events.Event;
import flash.geom.Rectangle;
import mx.events.PropertyChangeEvent;


/**
 *  The SolidColorStroke class defines the properties for a line. 
 *  
 *  You can define a SolidColorStroke object in MXML, but you must attach that SolidColorStroke to
 *  another object for it to appear in your application. The following example
 *  defines two SolidColorStroke objects and then uses them in the horizontalAxisRenderer
 *  of a LineChart control:
 *  
 *  <pre>
 *  ...
 *  &lt;mx:SolidColorStroke id="ticks" color="0xFF0000" weight="1"/&gt;
 *  &lt;mx:SolidColorStroke id="mticks" color="0x0000FF" weight="1"/&gt;
 *  
 *  &lt;mx:LineChart id="mychart" dataProvider="{ndxa}"&gt;
 *  	&lt;mx:horizontalAxisRenderer&gt;
 *  		&lt;mx:AxisRenderer placement="bottom" canDropLabels="true"&gt;
 *  			&lt;mx:tickStroke&gt;{ticks}&lt;/mx:tickStroke&gt;
 *  			&lt;mx:minorTickStroke&gt;{mticks}&lt;/mx:minorTickStroke&gt;
 *  		&lt;/mx:AxisRenderer&gt;
 *  	&lt;/mx:horizontalAxisRenderer&gt;
 *  &lt;/LineChart&gt;
 *  ...
 *  </pre>
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:SolidColorStroke&gt;</code> tag inherits all the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:SolidColorStroke
 *    <b>Properties</b>
 *    alpha="1.0"
 *    caps="null|none|round|square"
 *    color="0x000000"
 *    joints="null|bevel|miter|round"
 *    miterLimit="0"
 *    pixelHinting="false|true"
 *    scaleMode="normal|none|noScale|vertical"
 *    weight="1 (<i>in most cases</i>)"
 *  /&gt;
 *  </pre>
 *
 *  @see flash.display.Graphics
 */
public class SolidColorStroke extends EventDispatcher implements IStroke
{
	include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor. 
	 *
	 *  @param color Specifies the line color.
	 *  The default value is 0x000000 (black).
	 *
	 *  @param weight Specifies the line weight, in pixels.
	 *  The default value is 0.
	 *
	 *  @param alpha Specifies the alpha value in the range 0.0 to 1.0.
	 *  The default value is 1.0 (opaque).
	 *
	 *  @param pixelHinting Specifies whether to hint strokes to full pixels.
	 *  This value affects both the position of anchors of a curve
	 *  and the line stroke size itself.
	 *  The default value is false.
	 *
     *  @param scaleMode A value from the LineScaleMode class
     *  that specifies which scale mode to use.
     *  Valid values are <code>LineScaleMode.HORIZONTAL</code>,
     *  <code>LineScaleMode.NONE</code>, <code>LineScaleMode.NORMAL</code>,
     *  and <code>LineScaleMode.VERTICAL</code>.
     *  This parameter is optional,
     *  with a default value of <code>LineScaleMode.NONE</code>. 
	 *
	 *  @param caps Specifies the type of caps at the end of lines.
	 *  Valid values are <code>"round"</code>, <code>"square"</code>,
	 *  and <code>"none"</code>.
	 *  The default value is <code>null</code>.
	 *
	 *  @param joints Specifies the type of joint appearance used at angles.
	 *  Valid values are <code>"round"</code>, <code>"miter"</code>,
	 *  and <code>"bevel"</code>.
	 *  The default value is <code>null</code>.
	 *
	 *  @param miterLimit Indicates the limit at which a miter is cut off.
	 *  Valid values range from 0 to 255.
	 *  The default value is 0.
	 */
	public function SolidColorStroke(color:uint = 0x000000, weight:Number = 0,
						   alpha:Number = 1.0, pixelHinting:Boolean = false,
						   scaleMode:String = "none", caps:String = null,
						   joints:String = null, miterLimit:Number = 0)
	{
		super();

		this.color = color;
		this._weight = weight;
		this.alpha = alpha;
		this.pixelHinting = pixelHinting;
		this.scaleMode = scaleMode;
		this.caps = caps;
		this.joints = joints;
		this.miterLimit = miterLimit;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  alpha
	//----------------------------------

	private var _alpha:Number = 0.0;
	
	[Bindable("propertyChange")]
    [Inspectable(category="General")]

	/**
	 *  The transparency of a line.
	 *  Possible values are 0.0 (invisible) through 1.0 (opaque). 
	 *  
	 *  @default 1.0. 
	 */
	public function get alpha():Number
	{
		return _alpha;
	}
	
	public function set alpha(value:Number):void
	{
		var oldValue:Number = _alpha;
		if (value != oldValue)
		{
			_alpha = value;
			dispatchStrokeChangedEvent("alpha", oldValue, value);
		}
	}

	//----------------------------------
	//  caps
	//----------------------------------

	private var _caps:String = null;
	
	[Bindable("propertyChange")]
	[Inspectable(category="General", enumeration="round,square,none", defaultValue="round")]

	/**
	 *  Specifies the type of caps at the end of lines.
	 *  Valid values are: <code>"round"</code>, <code>"square"</code>,
	 *  and <code>"none"</code>.
	 */
	public function get caps():String
	{
		return _caps;
	}
	
	public function set caps(value:String):void
	{
		var oldValue:String = _caps;
		if (value != oldValue)
		{
			_caps = value;
			dispatchStrokeChangedEvent("caps", oldValue, value);
		}
	}
	
	//----------------------------------
	//  color
	//----------------------------------

	private var _color:uint = 0x000000;
	
	[Bindable("propertyChange")]
    [Inspectable(category="General", format="Color")]

	/**
	 *  The line color. 
	 *  
	 *  @default 0x000000 (black). 
	 */
	public function get color():uint
	{
		return _color;
	}
	
	public function set color(value:uint):void
	{
		var oldValue:uint = _color;
		if (value != oldValue)
		{
			_color = value;
			dispatchStrokeChangedEvent("color", oldValue, value);
		}
	}
	
	//----------------------------------
	//  joints
	//----------------------------------

	private var _joints:String = null;
	
	[Bindable("propertyChange")]
	[Inspectable(category="General", enumeration="round,bevel,miter", defaultValue="round")]

	/**
	 *  Specifies the type of joint appearance used at angles.
	 *  Valid values are <code>"round"</code>, <code>"miter"</code>,
	 *  and <code>"bevel"</code>.
	 */
	public function get joints():String
	{
		return _joints;
	}
	
	public function set joints(value:String):void
	{
		var oldValue:String = _joints;
		if (value != oldValue)
		{
			_joints = value;
			dispatchStrokeChangedEvent("joints", oldValue, value);
		}
	}
	
	//----------------------------------
	//  miterLimit
	//----------------------------------

	private var _miterLimit:Number = 0;
	
	[Bindable("propertyChange")]
	[Inspectable(category="General")]
	
	/**
	 *  Indicates the limit at which a miter is cut off.
	 *  Valid values range from 0 to 255.
	 *  
	 *  @default 0
	 */
	public function get miterLimit():Number
	{
		return _miterLimit;
	}
	
	public function set miterLimit(value:Number):void
	{
		var oldValue:Number = _miterLimit;
		if (value != oldValue)
		{
			_miterLimit = value;
			dispatchStrokeChangedEvent("miterLimit", oldValue, value);
		}
	}

	//----------------------------------
	//  pixelHinting
	//----------------------------------

	private var _pixelHinting:Boolean = false;
	
	[Bindable("propertyChange")]
    [Inspectable(category="General")]
	
	/**
	 *  Specifies whether to hint strokes to full pixels.
	 *  This value affects both the position of anchors of a curve
	 *  and the line stroke size itself.
	 *  
	 *  @default false
	 */
	public function get pixelHinting():Boolean
	{
		return _pixelHinting;
	}
	
	public function set pixelHinting(value:Boolean):void
	{
		var oldValue:Boolean = _pixelHinting;
		if (value != oldValue)
		{
			_pixelHinting = value;
			dispatchStrokeChangedEvent("pixelHinting", oldValue, value);
		}
	}
	
	//----------------------------------
	//  scaleMode
	//----------------------------------

	private var _scaleMode:String = "normal";
	
	[Bindable("propertyChange")]
	[Inspectable(category="General", enumeration="normal,vertical,horizontal,none", defaultValue="normal")]

	 /**
     *  A value from the LineScaleMode class
     *  that  specifies which scale mode to use.
     *  Value valids are:
     * 
     *  <ul>
     *  <li>
     *  <code>LineScaleMode.NORMAL</code>&#151;
     *  Always scale the line thickness when the object is scaled  (the default).
     *  </li>
     *  <li>
     *  <code>LineScaleMode.NONE</code>&#151;
     *  Never scale the line thickness.
     *  </li>
     *  <li>
     *  <code>LineScaleMode.VERTICAL</code>&#151;
     *  Do not scale the line thickness if the object is scaled vertically 
     *  <em>only</em>. 
     *  </li>
     *  <li>
     *  <code>LineScaleMode.HORIZONTAL</code>&#151;
     *  Do not scale the line thickness if the object is scaled horizontally 
     *  <em>only</em>. 
     *  </li>
     *  </ul>
     * 
     *  @default LineScaleMode.NORMAL
     */
	public function get scaleMode():String
	{
		return _scaleMode;
	}
	
	public function set scaleMode(value:String):void
	{
		var oldValue:String = _scaleMode;
		if (value != oldValue)
		{
			_scaleMode = value;
			dispatchStrokeChangedEvent("scaleMode", oldValue, value);
		}
	}

	//----------------------------------
	//  weight
	//----------------------------------

	/**
	 *  @private
	 *  Storage for the weight property.
	 */
	private var _weight:Number;

	[Bindable("propertyChange")]
    [Inspectable(category="General")]

	/**
	 *  The line weight, in pixels.
	 *  For many charts, the default value is 1 pixel.
	 */
	public function get weight():Number
	{
		return _weight;
	}
	
	/**
	 *  @private
	 */
	public function set weight(value:Number):void
	{
		var oldValue:Number = _weight;
		if (value != oldValue)
		{
			_weight = value;
			dispatchStrokeChangedEvent("weight", oldValue, value);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

	/**
	 *  Applies the properties to the specified Graphics object.
	 *  
	 *  @param g The Graphics object to which the SolidColorStroke's styles are applied.
	 */
	public function apply(g:Graphics):void
	{
		draw(g, new Rectangle());
	}
	
	public function draw(g:Graphics, rc:Rectangle):void
	{
		g.lineStyle(weight, color, alpha, pixelHinting,
					scaleMode, caps, joints, miterLimit);
	}
	
	/**
	 *  @private
	 */
	private function dispatchStrokeChangedEvent(prop:String, oldValue:*,
												value:*):void
	{
        dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, prop,
															oldValue, value));
	}
}

}
