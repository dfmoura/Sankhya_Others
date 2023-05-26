var OPENAI_API_KEY = "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";
var bTextToSpeechSupported = false;
var bSpeechInProgress = false;
var oSpeechRecognizer = null
var oSpeechSynthesisUtterance = null;
var oVoices = null;

function OnLoad() {
    if ("webkitSpeechRecognition" in window) {
    } else {
        //speech to text not supported
        lblSpeak.style.display = "none";
    }

    if ('speechSynthesis' in window) {
        bTextToSpeechSupported = true;

        speechSynthesis.onvoiceschanged = function () {
            oVoices = window.speechSynthesis.getVoices();
            for (var i = 0; i < oVoices.length; i++) {
                selVoices[selVoices.length] = new Option(oVoices[i].name, i);
            }
        };
    }
}

function ChangeLang(o) {
    if (oSpeechRecognizer) {
        oSpeechRecognizer.lang = selLang.value;
        //SpeechToText()
    }
}

function Send() {

    var sQuestion = txtMsg.value;
    if (sQuestion == "") {
        alert("Digite seu questionamento!");
        txtMsg.focus();
        return;
    }

    spMsg.innerHTML = "Chat GPT está processando a informação...";

    var sUrl = "https://api.openai.com/v1/completions";
    var sModel = selModel.value;// "text-davinci-003";
    if (sModel.indexOf("gpt-3.5-turbo") != -1) {
        //https://openai.com/research/gpt-4
        sUrl = "https://api.openai.com/v1/chat/completions";
    }

    var oHttp = new XMLHttpRequest();
    oHttp.open("POST", sUrl);
    oHttp.setRequestHeader("Accept", "application/json");
    oHttp.setRequestHeader("Content-Type", "application/json");
    oHttp.setRequestHeader("Authorization", "Bearer " + OPENAI_API_KEY)

    oHttp.onreadystatechange = function () {
        if (oHttp.readyState === 4) {
            //console.log(oHttp.status);

            spMsg.innerHTML = "";

            var oJson = {}
            if (txtOutput.value != "") txtOutput.value += "\n";

            try {
                oJson = JSON.parse(oHttp.responseText);
            } catch (ex) {
                txtOutput.value += "Error: " + ex.message
            }

            if (oJson.error && oJson.error.message) {
                txtOutput.value += "Error: " + oJson.error.message;

            } else if (oJson.choices) {
                var s = "";

                if (oJson.choices[0].text) {
                    s = oJson.choices[0].text;

                } else if (oJson.choices[0].message) {
                    //GPT-4
                    s = oJson.choices[0].message.content;
                }

                if (selLang.value != "en-US") {
                    var a = s.split("?\n");
                    if (a.length == 2) {
                        s = a[1];
                    }
                }

                if (s == "") {
                    s = "No response";
                } else {
                    txtOutput.value += "Chat GPT: " + s;
                    TextToSpeech(s);
                }
            }
        }
    };

    var iMaxTokens = 2048;
    var sUserId = "1";
    var dTemperature = 0.5;

    var data = {
        model: sModel,
        prompt: sQuestion,
        max_tokens: iMaxTokens,
        user: sUserId,
        temperature: dTemperature,
        frequency_penalty: 0.0, //Number between -2.0 and 2.0  
                                //Positive value decrease the model's likelihood 
                                //to repeat the same line verbatim.
        presence_penalty: 0.0,  //Number between -2.0 and 2.0. 
                                //Positive values increase the model's likelihood 
                                //to talk about new topics.
        stop: ["#", ";"]        //Up to 4 sequences where the API will stop generating 
                                //further tokens. The returned text will not contain 
                                //the stop sequence.
    }

    //chat GPT-4 gpt-4
    if (sModel.indexOf("gpt-3.5-turbo") != -1) {
        data = {
            "model": sModel,
            "messages": [
                //{
                //    "role": "system",
                //    "content": "You are a helpful assistant."  
                //                assistant messages help store prior responses
                //},
                {
                    "role": "user", //system,user,assistant
                    "content": sQuestion
                }
            ]
        }
    }

    oHttp.send(JSON.stringify(data));

    if (txtOutput.value != "") txtOutput.value += "\n";
    txtOutput.value += "Me: " + sQuestion;
    txtMsg.value = "";
}

function TextToSpeech(s) {
    if (bTextToSpeechSupported == false) return;
    if (chkMute.checked) return;

    oSpeechSynthesisUtterance = new SpeechSynthesisUtterance();

    if (oVoices) {
        var sVoice = selVoices.value;
        if (sVoice != "") {
            oSpeechSynthesisUtterance.voice = oVoices[parseInt(sVoice)];
        }        
    }    

    oSpeechSynthesisUtterance.onend = function () {
        //finished talking - can now listen
        if (oSpeechRecognizer && chkSpeak.checked) {
            oSpeechRecognizer.start();
        }
    }

    if (oSpeechRecognizer && chkSpeak.checked) {
        //do not listen to yourself when talking
        oSpeechRecognizer.stop();
    }

    oSpeechSynthesisUtterance.lang = selLang.value;
    oSpeechSynthesisUtterance.text = s;
    //Uncaught (in promise) Error: A listener indicated an asynchronous response 
    //by returning true, but the message channel closed 
    window.speechSynthesis.speak(oSpeechSynthesisUtterance);
}

function Mute(b) {
    if (b) {
        selVoices.style.display = "none";
    } else {
        selVoices.style.display = "";
    }
}

function SpeechToText() {

    if (oSpeechRecognizer) {

        if (chkSpeak.checked) {
            oSpeechRecognizer.start();
        } else {
            oSpeechRecognizer.stop();
        }

        return;
    }    

    oSpeechRecognizer = new webkitSpeechRecognition();
    oSpeechRecognizer.continuous = true;
    oSpeechRecognizer.interimResults = true;
    oSpeechRecognizer.lang = selLang.value;
    oSpeechRecognizer.start();

    oSpeechRecognizer.onresult = function (event) {
        var interimTranscripts = "";
        for (var i = event.resultIndex; i < event.results.length; i++) {
            var transcript = event.results[i][0].transcript;

            if (event.results[i].isFinal) {
                txtMsg.value = transcript;
                Send();
            } else {
                transcript.replace("\n", "<br>");
                interimTranscripts += transcript;
            }

            var oDiv = document.getElementById("idText");
            oDiv.innerHTML = '<span style="color: #999;">' + 
                               interimTranscripts + '</span>';
        }
    };

    oSpeechRecognizer.onerror = function (event) {

    };
}