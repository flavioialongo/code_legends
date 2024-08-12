// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


import { EditorState } from "@codemirror/state";
import { EditorView, basicSetup } from "@codemirror/basic-setup";
import { javascript } from "@codemirror/lang-javascript";
import { python } from "@codemirror/lang-python";
import { cpp } from "@codemirror/lang-cpp";
import { java } from "@codemirror/lang-java";
import { oneDark } from "@codemirror/theme-one-dark";

// Event that gets triggered when the page loads
document.addEventListener('DOMContentLoaded', () => {
    const editorElement = document.querySelector('#code-editor');
    const languageSelector = document.querySelector('#language-selector');
    let currentLanguage = 'javascript';
    let languageExtension = javascript();

    if (editorElement && languageSelector) {

        // Handle the languages extensions
        const createEditor = (language)=>{
            switch (language){
                case 'javascript':
                    currentLanguage = 'javascript';
                    languageExtension = javascript();
                    break;
                case 'python':
                    currentLanguage = 'python';
                    languageExtension = python();
                    break;
                case 'java':
                    currentLanguage = 'java';
                    languageExtension = java();
                    break;
                case 'cpp':
                    currentLanguage = 'cpp';
                    languageExtension = cpp();
                    break;
                default:
                    currentLanguage = 'javascript';
                    languageExtension = javascript();
            }

            // Creating the Editor using CodeMirror
            const state = EditorState.create({
                doc: 'Hello, World!',
                extensions: [basicSetup, languageExtension, oneDark]
            });
            new EditorView({
                state,
                parent: editorElement
            });
        }

        createEditor(currentLanguage);

        // Event that gets triggered when the user changes language
        // Automatically changes the editor language
        languageSelector.addEventListener('change', (event) => {
            const selectedLanguage = event.target.value;
            editorElement.innerHTML = ''; // Clear the existing editor
            createEditor(selectedLanguage);
        });
    }



});




