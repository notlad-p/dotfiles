import { property, register } from "astal";
import { Gtk } from "astal/gtk4";
import cairo from "gi://cairo?version=1.0";

@register({ GTypeName: "TemperatureRange" })
class TemperatureRange extends Gtk.DrawingArea {
  private declare _lowTemp;
  private declare _highTemp;

  @property(Number)
  declare minTemp: number;

  @property(Number)
  declare maxTemp: number;

  constructor() {
    super({ minTemp: 60, maxTemp: 80, lowTemp: 65, highTemp: 75 }) as any;

    // Set minimum size for the widget
    // this.set_content_width(200);
    this.set_content_height(5);

    // Set up the drawing callback
    this.set_draw_func(this._draw.bind(this));
  }

  // Getter/setter for low temperature
  @property(Number)
  get lowTemp() {
    return this._lowTemp;
  }

  set lowTemp(value) {
    this._lowTemp = value;
    this.queue_draw(); // Trigger redraw when value changes
  }

  // Getter/setter for high temperature
  @property(Number)
  get highTemp() {
    return this._highTemp;
  }

  set highTemp(value) {
    this._highTemp = value;
    this.queue_draw(); // Trigger redraw when value changes
  }

  // Convert temperature to X position
  _tempToPosition(temp, allocation) {
    const range = this.maxTemp - this.minTemp;
    const percentage = (temp - this.minTemp) / range;
    const width = allocation.width - 20; // Subtract padding
    return 10 + percentage * width;
  }

  // Draw the widget
  _draw(widget, cr, width, height) {
    const allocation = { width, height };


    // Temperature range
    const lowX = this._tempToPosition(this._lowTemp, allocation);
    const highX = this._tempToPosition(this._highTemp, allocation);

    const lineWidth = 5;

    // Background track
    cr.setSourceRGBA(1, 1, 1, 0.15);
    cr.moveTo(lineWidth, lineWidth / 2);
    cr.lineTo(width - lineWidth, lineWidth / 2);
    cr.setLineWidth(lineWidth);
    cr.setLineCap(cairo.LineCap.ROUND);
    cr.stroke();

    // Draw temperature range bar
    cr.setSourceRGB(0.4039, 0.5686, 0.7882);
    cr.moveTo(lowX, lineWidth / 2);
    cr.lineTo(highX, lineWidth / 2);
    cr.setLineWidth(lineWidth);
    cr.setLineCap(cairo.LineCap.ROUND);
    cr.stroke();
  }
}

export default TemperatureRange;
