import { Variable } from "astal";

type DateTimeProps = {
  format?: string;
  cssClasses?: string[];
};

const DateTime = ({ format = "%H:%M - %A %e.", cssClasses = [] }: DateTimeProps) => {
  const time = Variable("").poll(1000, `date "+${format}"`);

  return <label cssClasses={["date-time", ...cssClasses]} label={time()} />;
};

export default DateTime;
