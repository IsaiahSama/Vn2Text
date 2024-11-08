# voice_note_to_text

This application will serve to take whatsapp voice notes, and transcribe them into text for your ease of use.

## The Speech to Text

I'll be making use of one of my other projects for the [Speech to Text](https://github.com/IsaiahSama/SpeechToTextAPI). 

Currently testing, so will have it on localhost, but will eventuallly publish it so it works from mobile devices.

Note: The application **REQUIRES** a server to handle the transcription.

For now, it's set to look for localhost on port 5000, having been built to work with my other project, but the code and endpoint can be changed. 

## Running the application.

### For Developers

1. Clone this repository. Ensure you have Flutter and Android Studio installed. (I've done nothing for Ios, so if you have an apple device will have to build it yourself).
2. Copy the `.env.sample` file, rename the copy to `.env` and fill in the necessary values. Only the transcription URL is mandatory.
3. If planning on using my [Speech to Text](https://github.com/IsaiahSama/SpeechToTextAPI) project, be sure to clone that repo, and set it up first, then copy the URL and assign that as the TRANSCRIPTION_URL in the .env file.

Note: May need to modify the code in `./lib/src/client.dart` for it to work with your API

### For Non-Developers.

1. Download the app from [this url](https://example.com/).
2. No transcription URL, so not for non-developers currently.