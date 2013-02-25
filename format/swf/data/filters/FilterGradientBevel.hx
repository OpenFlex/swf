﻿package format.swf.data.filters;

import format.swf.utils.ColorUtils;

import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterType;
import flash.filters.GradientBevelFilter;

class FilterGradientBevel extends FilterGradientGlow #if !haxe3 , #end implements IFilter
{
	public function new (id:Int) {
		super(id);
	}
	
	override private function get_filter():BitmapFilter {
		var gradientGlowColors:Array<Int> = [];
		var gradientGlowAlphas:Array<Float> = [];
		var gradientGlowRatios:Array<Float> = [];
		for (i in 0...numColors) {
			gradientGlowColors.push(ColorUtils.rgb(gradientColors[i]));
			gradientGlowAlphas.push(ColorUtils.alpha(gradientColors[i]));
			gradientGlowRatios.push(gradientRatios[i]);
		}
		var filterType:BitmapFilterType;
		if(onTop) {
			filterType = BitmapFilterType.FULL;
		} else {
			filterType = (innerShadow) ? BitmapFilterType.INNER : BitmapFilterType.OUTER;
		}
		return new GradientBevelFilter(
			distance,
			angle,
			gradientGlowColors,
			gradientGlowAlphas,
			gradientGlowRatios,
			blurX,
			blurY,
			strength,
			passes,
			Std.string (filterType),
			knockout
		);
	}
	
	override public function clone():IFilter {
		var filter:FilterGradientBevel = new FilterGradientBevel(id);
		filter.numColors = numColors;
		var i:Int;
		for (i in 0...numColors) {
			filter.gradientColors.push(gradientColors[i]);
		}
		for (i in 0...numColors) {
			filter.gradientRatios.push(gradientRatios[i]);
		}
		filter.blurX = blurX;
		filter.blurY = blurY;
		filter.angle = angle;
		filter.distance = distance;
		filter.strength = strength;
		filter.passes = passes;
		filter.innerShadow = innerShadow;
		filter.knockout = knockout;
		filter.compositeSource = compositeSource;
		filter.onTop = onTop;
		return filter;
	}
	
	override private function get_filterName():String { return "GradientBevelFilter"; }
}