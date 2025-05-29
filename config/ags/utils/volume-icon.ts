const getVolumeIcon = (
  isInput: boolean,
  isMuted: boolean,
  volumeVal: number,
): string => {
  if (isInput) {
    // input icons
    if (isMuted) {
      return "microphone-mute-red";
    }

    if (volumeVal > 1) {
      return "microphone-overamplified";
    } else if (volumeVal > 0.66 && volumeVal <= 1) {
      return "microphone-high";
    } else if (volumeVal > 0.33 && volumeVal <= 0.66) {
      return "microphone-medium";
    } else if (volumeVal > 0 && volumeVal <= 0.33) {
      return "microphone-low";
    } else {
      return "microphone-none";
    }
  } else {
    // output icons
    if (isMuted) {
      return "volume-mute-red";
    }

    if (volumeVal > 1) {
      return "volume-overamplified";
    } else if (volumeVal > 0.66 && volumeVal <= 1) {
      return "volume-high";
    } else if (volumeVal > 0.33 && volumeVal <= 0.66) {
      return "volume-medium";
    } else if (volumeVal > 0 && volumeVal <= 0.33) {
      return "volume-low";
    } else {
      return "volume-none";
    }
  }
};

export default getVolumeIcon;
