import { bind, GLib, Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";

import archUpdates from "services/arch-updates";
import { PowerMenuWindowName } from "./PowerMenu";

export const OperatingSystemWindowName = "operatingSystem";

const OperatingSystem = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, LEFT } = Astal.WindowAnchor;

  const monitorName = gdkmonitor.get_connector();

  // update uptime every minute
  const uptime = Variable("Uptime:").poll(1000 * 60, [
    "bash",
    "-c",
    "~/.config/ags/scripts/uptime.sh",
  ]);

  const handleUpdateButtonClick = () => {
    archUpdates.download_updates();
  };

  const updatesText = bind(archUpdates, "data").as(({ arch, aur }) => {
    if (arch > 0 || aur > 0) {
      return `Package Updates: ${arch} pacman | ${aur} AUR`;
    }

    return "Packages up to date";
  });

  const isUpdatesAvailable = bind(archUpdates, "data").as(({ arch, aur }) => {
    return arch > 0 || aur > 0;
  });

  const handlePowerClick = () => {
    App.toggle_window(`${PowerMenuWindowName}-${monitorName}`);
  };

  // TODO: add this to all popup widgets:
  // keymode={Astal.Keymode.EXCLUSIVE}
  // onKeyPressed={(_, keyval) => {
  //   if (keyval === Gdk.KEY_Escape) {
  //     App.toggle_window(`${OperatingSystemWindowName}-${monitorName}`);
  //   }
  // }}

  // TODO: Close left / middle widgets when others are opened

  return (
    <window
      layer={Astal.Layer.TOP}
      marginTop={52}
      marginLeft={8}
      name={`${OperatingSystemWindowName}-${monitorName}`}
      cssClasses={["bg-black-900", "rounded-lg", "text-white-500", "p-4"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | LEFT}
      application={App}
      defaultWidth={10}
      defaultHeight={10}
      overflow={Gtk.Overflow.HIDDEN}
    >
      <box vertical spacing={12}>
        <box cssClasses={["p-3", "bg-black-800", "rounded-lg", "min-w-sm"]}>
          <image
            file={`/home/${GLib.get_user_name()}/.face`}
            overflow={Gtk.Overflow.HIDDEN}
            widthRequest={64}
            heightRequest={64}
            cssClasses={["rounded-full"]}
          />
          <box
            vertical
            valign={Gtk.Align.CENTER}
            spacing={6}
            cssClasses={["pl-4"]}
          >
            <label
              halign={Gtk.Align.START}
              cssClasses={["font-semibold"]}
              label={GLib.get_user_name()}
            />
            <label
              halign={Gtk.Align.START}
              cssClasses={["text-white-500/80", "text-sm"]}
              label={bind(uptime).as((up) => `Uptime: ${up}`)}
            />
          </box>
          <button
            onClicked={handlePowerClick}
            hexpand
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.END}
            cssClasses={[
              "p-3",
              "bg-black-600",
              "hover:bg-black-500",
              "transition",
              "duration-200",
            ]}
          >
            <image iconName="power" cssClasses={["icon-5"]} />
          </button>
        </box>
        <box spacing={8}>
          <image
            valign={Gtk.Align.CENTER}
            iconName={isUpdatesAvailable.as((isAvail) =>
              isAvail ? "package-updates" : "package-custom",
            )}
            cssClasses={["icon-5"]}
          />
          <label valign={Gtk.Align.CENTER} label={updatesText} />

          {/* only show download button if updates available */}
          {isUpdatesAvailable.as((isAvail) =>
            isAvail ? (
              <button
                valign={Gtk.Align.CENTER}
                cssClasses={[
                  "ml-1",
                  "p-1.5",
                  "bg-black-700",
                  "bg-black-700",
                  "hover:bg-black-600",
                  "transition",
                  "duration-200",
                ]}
                onClicked={handleUpdateButtonClick}
              >
                <image iconName="download-custom" cssClasses={["icon-4"]} />
              </button>
            ) : (
              <></>
            ),
          )}
          {/* {isUpdatesAvailable.get() && ( */}
          {/* )} */}
        </box>
      </box>
    </window>
  );
};

export default OperatingSystem;
