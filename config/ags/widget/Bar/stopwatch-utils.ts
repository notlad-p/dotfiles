import { AstalIO, Variable } from "astal";
import { interval, timeout } from "astal/time";

export let isStarted = Variable(false);
export let secondsEllapsed = Variable(0);
let timer: AstalIO.Time | null = null;
let waitTimeout: AstalIO.Time | null = null;

export const toggle = () => {
  if (!isStarted.get()) {
    isStarted.set(true);
    // wait one second when timer is started
    // because `interval` function is run immediately when invoked
    waitTimeout = timeout(1000, () => {
      timer = interval(1000, () => {
        const sec = secondsEllapsed.get();
        secondsEllapsed.set(sec + 1);
      });
    });
  } else {
    isStarted.set(false);
    timer?.cancel();
    timer = null;
    waitTimeout?.cancel();
    waitTimeout = null;
  }
};

export const formatTimerString = (seconds: number) => {
  const hh = Math.floor(seconds / (60 * 60))
    .toString()
    .padStart(2, "0");
  const mm = Math.floor((seconds / 60) % 60)
    .toString()
    .padStart(2, "0");
  const ss = (seconds % 60).toString().padStart(2, "0");

  return `${hh}:${mm}:${ss}`;
};
