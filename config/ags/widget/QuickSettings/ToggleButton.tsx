import { type Binding } from "astal";
import { Gtk } from "astal/gtk4";

type ToggleButtonProps = {
  toggled: Binding<boolean>;
  iconOn: string;
  iconOff: string;
  onClicked: (btn: Gtk.Button) => void;
};

const ToggleButton = ({
  toggled,
  iconOn,
  iconOff,
  onClicked,
}: ToggleButtonProps) => {
  return (
    <button
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      cssClasses={toggled.as((isToggled) => {
        return [
          isToggled ? "bg-blue-500" : "bg-black-800",
          isToggled ? "hover:bg-blue-400" : "hover:bg-black-700",
          "rounded-lg",
          "p-3",
          "transition",
          "duration-200",
        ];
      })}
      onClicked={(btn) => {
        // toggled((isToggled) => !isToggled);
        // toggled.set(!toggled.get());
        onClicked(btn);
      }}
      tooltipMarkup="Test"
    >
      <image
        iconName={toggled.as((isToggled) => (isToggled ? iconOn : iconOff))}
      />
    </button>
  );
};

export default ToggleButton;
