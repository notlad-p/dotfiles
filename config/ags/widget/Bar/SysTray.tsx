// function SysTray() {
//   const tray = Tray.get_default();
//
//   return (
//     <box cssClasses={["SysTray"]}>
//       {bind(tray, "items").as((items) =>
//         items.map((item) => (
//           <menubutton
//             tooltipMarkup={bind(item, "tooltipMarkup")}
//             // usePopover={false}
//             setup={(self) => {
//               self.insert_action_group("dbusmenu", item.actionGroup);
//             }}
//             menuModel={bind(item, "menuModel")}
//           >
//             <image gicon={bind(item, "gicon")} />
//           </menubutton>
//         )),
//       )}
//     </box>
//   );
// }

import { Gtk } from "astal/gtk4";

const SysTray = () => {
  return (
    <box>
      <button
        cssClasses={[
          "bg-black-900",
          "hover:bg-black-800",
          "rounded-lg",
          "p-1.5",
          "transition",
        ]}
        vexpand={false}
        hexpand={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
      >
        <image iconName="caret-bar-symbolic" />
      </button>
    </box>
  );
};

export default SysTray;
