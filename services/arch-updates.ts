import { execAsync, interval, subprocess } from "astal";
import GObject, { register, property } from "astal/gobject";

const REFRESH_MIN = 30;

type UpdatesData = {
  arch: number;
  aur: number;
};

const DEFAULT_VALUES = {
  arch: 0,
  aur: 0,
};

@register()
class ArchUpdates extends GObject.Object {
  @property(Object)
  declare data: UpdatesData;

  private async _get_updates(force: boolean = false) {
    try {
      const res = await execAsync([
        "bash",
        "-c",
        `~/.config/ags/scripts/updates.sh ${force}`,
      ]);

      const resData: UpdatesData = JSON.parse(res);

      this.data = resData;
    } catch (error) {
      console.error(error);
    }
  }

  async download_updates() {
    // TODO: add hyprland windowrule kitty class line to readme
    await execAsync(["bash", "-c", `kitty --class astal-paru-update paru`]);

    await this._get_updates(true);
  }

  constructor() {
    super();

    this.data = DEFAULT_VALUES;

    interval(1000 * 60 * REFRESH_MIN, async () => {
      await this._get_updates();
    });
  }
}

const archUpdates = new ArchUpdates();
export default archUpdates;
