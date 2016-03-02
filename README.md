# OmniAuth Darkscience IRC

This is the official OmniAuth strategy for authenticating to Darkscience IRC.

## Basic Usage

    use OmniAuth::Builder do
      provider :darkscience, ENV['DARKSCIENCE_KEY'], ENV['DARKSCIENCE_SECRET']
    end
