// modified version of Jas-SinghFSU/HyprPanel monitor refresh implementation:
// https://github.com/Jas-SinghFSU/HyprPanel/blob/20532ee760fdf492afcf987ae091497a37878197/src/services/display/bar/refreshManager.ts#L38
import { App } from "astal/gtk4";
import { timeout, Time } from "astal";
import { createWindows } from "../app";

let refreshInProgress = false;
let pendingRefresh = false;
let monitorChangeTimeout: Time | null = null;

const refreshWindows = async () => {
  if (refreshInProgress) {
    pendingRefresh = true;
    return;
  }

  refreshInProgress = true;

  try {
    // destroy current windows
    App.get_windows().forEach((window) => window?.destroy());
  } catch (error) {
    console.error("Error occured while refreshing monitor widgets:", error);
  } finally {
    refreshInProgress = false;
    // create new windows on each screen
    createWindows();

    if (pendingRefresh) {
      pendingRefresh = false;
      timeout(100, () => refreshWindows());
    }
  }
};

const handleMonitorChange = () => {
  if (monitorChangeTimeout !== null) {
    monitorChangeTimeout.cancel();
  }

  monitorChangeTimeout = timeout(400, () => {
    refreshWindows().catch((error) => {
      console.error("Failed to destroy windows on monitor change:", error);
    });
    monitorChangeTimeout = null;
  });
};

export default handleMonitorChange;
