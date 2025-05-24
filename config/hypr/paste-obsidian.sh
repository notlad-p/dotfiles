#!/bin/bash

# Script to paste markdown links from currently focused Zen Browser into obsidian
hyprctl dispatch sendshortcut SHIFT CONTROL ALT, C,
hyprctl dispatch focuswindow class:obsidian
hyprctl dispatch sendshortcut , escape,
hyprctl dispatch sendshortcut SHIFT, A,
hyprctl dispatch sendshortcut , Return,
sleep 0.1
hyprctl dispatch sendshortcut , escape,
hyprctl dispatch sendshortcut , P,

# This is needed for paste to work properly (It's slow I guess?)
sleep 0.1

hyprctl dispatch focuscurrentorlast
