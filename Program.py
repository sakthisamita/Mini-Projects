import os
import random
import tkinter as tk
from tkinter import messagebox
from tkinter import scrolledtext
from pygame import mixer

# Initialize the pygame mixer
mixer.init()

# Define a list of moods and corresponding folder paths and colors
moods = {
    "Sad": {"path": "music/Sad", "color": "#6495ED"},  # Light Blue
    "Happy": {"path": "music/Happy", "color": "#FFD700"},  # Gold
    "Energetic": {"path": "music/Energetic", "color": "#32CD32"},  # Lime Green
    "Exuberant": {"path": "music/Exuberant", "color": "#FF69B4"},  # Hot Pink
    "Frantic": {"path": "music/Frantic", "color": "#FF4500"},  # Orange Red
}

# Function to play music from a selected mood folder
def play_music(mood):
    folder_path = moods[mood]["path"]
    if not folder_path or not os.path.isdir(folder_path):
        messagebox.showerror("Error", f"No folder found for mood: {mood}")
        return
    
    # Get all mp3 files in the mood folder
    music_files = [f for f in os.listdir(folder_path) if f.endswith('.mp3')]
    if not music_files:
        messagebox.showinfo("No Music", f"No mp3 files found in the {mood} folder.")
        return

    # Choose a random music file and play it
    music_file = random.choice(music_files)
    music_path = os.path.join(folder_path, music_file)
    
    # Stop any currently playing music
    mixer.music.stop()
    
    # Load and play the selected music file
    mixer.music.load(music_path)
    mixer.music.play()

    # Display lyrics if available
    lyrics_path = os.path.splitext(music_path)[0] + ".txt"
    if os.path.exists(lyrics_path):
        with open(lyrics_path, 'r', encoding="utf-8") as file:
            lyrics_text.delete(1.0, tk.END)
            lyrics_text.insert(tk.END, file.read())
    else:
        lyrics_text.delete(1.0, tk.END)
        lyrics_text.insert(tk.END, "Lyrics not available for this song.")

    messagebox.showinfo("Playing", f"Playing {music_file} from {mood} mood")

# Function to stop the music
def stop_music():
    mixer.music.stop()
    lyrics_text.delete(1.0, tk.END)
    lyrics_text.insert(tk.END, "Music has been stopped.")
    messagebox.showinfo("Music Stopped", "Music has been stopped.")

# Setting up the tkinter window
window = tk.Tk()
window.title("Mood Music Player")
window.geometry("800x700")  # Larger window to better display lyrics

# Set a larger font size
font_size = 16  # Adjust size as needed
font_style = ("Arial", font_size)

# Add mood buttons
for mood, attributes in moods.items():
    button = tk.Button(window, text=mood, width=25, height=2, bg=attributes["color"], 
                       command=lambda m=mood: play_music(m), font=font_style)
    button.pack(pady=10)

# Add a stop button
stop_button = tk.Button(window, text="Stop Music", width=25, height=2, bg="#A9A9A9", 
                        command=stop_music, font=font_style)
stop_button.pack(pady=20)

# Add a scrolled text widget for displaying lyrics
lyrics_text = scrolledtext.ScrolledText(window, wrap=tk.WORD, width=80, height=20, font=("Arial", 14))
lyrics_text.pack(pady=20)
lyrics_text.insert(tk.END, "Lyrics will appear here once the music starts.")

# Run the tkinter main loop
window.mainloop()

