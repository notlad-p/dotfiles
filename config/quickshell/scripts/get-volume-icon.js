function getVolumeIcon(node) {
  const isInput = !node.isSink;
  const isMuted = node.audio.muted;
  const volumeVal = Math.round(node.audio.volume * 100);

  if (isInput) {
    // input icons
    if (isMuted) {
      return "microphone-mute";
    }

    if (volumeVal > 100) {
      return "microphone-overamplified";
    } else if (volumeVal > 66 && volumeVal <= 100) {
      return "microphone-high";
    } else if (volumeVal > 33 && volumeVal <= 66) {
      return "microphone-medium";
    } else if (volumeVal > 0 && volumeVal <= 33) {
      return "microphone-low";
    } else {
      return "microphone-none";
    }
  } else {
    // output icons
    if (isMuted) {
      return "volume-mute";
    }

    if (volumeVal > 100) {
      return "volume-overamplified";
    } else if (volumeVal > 66 && volumeVal <= 100) {
      return "volume-high";
    } else if (volumeVal > 33 && volumeVal <= 66) {
      return "volume-medium";
    } else if (volumeVal > 0 && volumeVal <= 33) {
      return "volume-low";
    } else {
      return "volume-none";
    }
  }
}
