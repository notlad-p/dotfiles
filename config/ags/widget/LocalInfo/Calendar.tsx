import { bind, exec, execAsync, Variable } from "astal";
import { Gtk } from "astal/gtk4";

type DayProps = {
  day: number;
  weekIdx: number;
};

const Day = ({ day, weekIdx }: DayProps) => {
  const todayDay = Number(exec(`date "+%e"`));
  const classes = ["day"];

  if ((weekIdx === 0 && day > 8) || (weekIdx === 4 && day < 8)) {
    classes.push("day-grey");
  }

  if (todayDay === day) {
    classes.push("day-today");
  }

  return (
    <label
      label={String(day)}
      hexpand
      halign={Gtk.Align.FILL}
      cssClasses={classes}
    />
  );
};

const Calendar = () => {
  const weeks = Variable<number[][] | []>([]);

  execAsync(["bash", "-c", "~/.config/ags/widget/LocalInfo/cal.sh"])
    .then((out) => {
      let [dayOfWeekOffset, firstDayNum, monLen] = out.split(" ");
      const monthLen = Number(monLen);

      const mnth = [];

      const NUM_DAYS_IN_CAL = 35;

      const offset = Number(dayOfWeekOffset);

      for (let i = 0; i < NUM_DAYS_IN_CAL; i++) {
        let dayNum: number | null;
        if (i < offset) {
          dayNum = Number(firstDayNum) + i;
        } else if (i + 1 - offset > monthLen) {
          dayNum = i + 1 - offset - monthLen;
        } else {
          dayNum = i + 1 - offset;
        }

        mnth.push(dayNum);
      }

      const monthWeeks = [];
      for (let i = 0; i < NUM_DAYS_IN_CAL; i += 7) {
        const week = mnth.slice(i, i + 7);
        monthWeeks.push(week);
      }

      weeks.set(monthWeeks);
    })
    .catch((err) => console.error(err));

  const daysOfWeek = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  return (
    <box vertical cssClasses={["cal"]}>
      <centerbox cssClasses={["cal-header"]}>
        <button cssClasses={["btn-icon"]}>
          <image iconName="caret-left-symbolic" />
        </button>
        <label label="April, 2025" />
        <button cssClasses={["btn-icon"]}>
          <image iconName="caret-right-symbolic" />
        </button>
      </centerbox>

      <box spacing={12}>
        {daysOfWeek.map((day) => (
          <label
            label={day}
            hexpand
            halign={Gtk.Align.FILL}
            cssClasses={["day-of-week"]}
          />
        ))}
      </box>

      {bind(weeks).as((w) =>
        w.map((week, weekIdx) => (
          <box spacing={12}>
            {week.map((day) => (
              <Day day={day} weekIdx={weekIdx} />
            ))}
          </box>
        )),
      )}
    </box>
  );
};

export default Calendar;
