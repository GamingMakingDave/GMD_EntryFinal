
let quiz_right_answers = 0;
let quiz_wrong_answers = 0;
let question_list = document.querySelector(".questions");
let question_title = document.querySelector("#question");
var isQuestioning = true;
var currentQuestionIndex = 1;



function ChangeLanguage(lang) {
  document.querySelector("#send_question").innerHTML = Language[lang]["btn_next"];
  document.querySelector("#questions_continue").innerHTML = Language[lang]["btn_finished"];

  document.querySelector(".container .question_container .information p:nth-child(1)").innerHTML = Language[lang]["rulesbook"];
  document.querySelector(".container .question_container .information p:nth-child(3)").innerHTML = Language[lang]["morethan4answers"];
  document.querySelector(".container .question_container .information strong:nth-child(4)").innerHTML = Language[lang]["7days"];

  document.querySelector(".container .question_container header .bigTitle").innerHTML = Language[lang]["rulesquery"];
  document.querySelector(".container .question_container header .littleTitle").innerHTML = Language[lang]["letsGetStarted"];

  document.querySelector("#start_button").innerHTML = Language[lang]["btn_start"];

}

ChangeLanguage(Language.Using)



function NextQuestion() {
  if(isQuestioning) {
    if (currentQuestionIndex - 1 == questions.length) {
      question_list.innerHTML = "";
      question_title.querySelector(".bigTitle").innerHTML = Language[Language.Using]["QuizEnded"];
      question_title.querySelector(".littleTitle").innerHTML = `${Language[Language.Using]["RightAnswers:"]} ${quiz_right_answers} | ${Language[Language.Using]["WrongAnswers:"]} ${quiz_wrong_answers}`;
      
      
      /* Abfrage ob bestanden */
      if(quiz_right_answers < GMDEntry.FailureQuestions) {
        document.querySelector(".task_container .grund").innerHTML = Language[Language.Using]["QuizFailed"];
        document.querySelector(".task_container").classList.add("expand");
        document.querySelector(".task_container .grund").style.display  = "";
        // FRAGEZEICHEN = document.querySelector(".task_container .big-icon-back").setAttribute("icon", "fa6-solid:question");
        document.querySelector(".task_container .big-icon-back").setAttribute("icon", "ic:outline-cancel");
        document.querySelector(".task_container .big-icon-back").style = "color: rgba(255,0,0,0.03); filter: drop-shadow(0 0 10px rgba(255,0,0,0.3));"
        document.querySelector(".task_container").style = "background: radial-gradient(50% 50% at 50% 50%, rgb(37, 1, 1) 0%, rgb(0, 0, 0) 100%); border: 2px solid #FF1A35;"
        
        
        question_title.querySelector(".bigTitle").style = `background: linear-gradient(90.4deg, #FF1A35 0.2%, rgba(255, 26, 53, 0.74) 99.85%); -webkit-background-clip: text;`
        document.querySelector("#send_question").style.display = "none";
        document.querySelector("#disconnect").style = "background: linear-gradient(90.4deg, #FF1A35 0.2%, rgba(255, 26, 53, 0.74) 99.85%);";
        document.querySelector("#disconnect").style.display = "";
        
      }
      else {
        document.querySelector(".task_container").classList.add("expand");
        document.querySelector(".task_container .grund").innerHTML = Language[Language.Using]["QuizPassed"];
        document.querySelector(".task_container .grund").style.display  = "";
        document.querySelector(".task_container .big-icon-back").setAttribute("icon", "mdi:success-circle-outline");
        document.querySelector(".task_container .big-icon-back").style = "color: rgba(0,255,0,0.1); filter: drop-shadow(0 0 10px rgba(0,255,0,0.3));"
        document.querySelector(".task_container").style = "background: radial-gradient(50% 50% at 50% 50%, rgb(3, 37, 1) 0%, rgb(0, 0, 0) 100%); border: 2px solid rgb(23, 211, 16);"
        
        question_title.querySelector(".bigTitle").style = `background: linear-gradient(90.4deg, #40ff1a 0.2%, rgba(26, 255, 45, 0.74) 99.85%); -webkit-background-clip: text;`
        
        document.querySelector("#send_question").style.display = "none";

        document.querySelector("#questions_continue").style = "background: linear-gradient(90.4deg, #1dfc00 0.2%, rgba(30, 161, 19, 0.74) 99.85%);";
        document.querySelector("#questions_continue").style.display = "";
      }
      
      isQuestioning = false;
      return
    }
    question_list.innerHTML = "";
    let question = questions[currentQuestionIndex - 1];
    question_title.querySelector(".littleTitle").innerHTML = question.question_text;
    question_title.querySelector(".bigTitle").innerHTML = `${Language[Language.Using]["Question:"]} ${questions.indexOf(question) + 1}`;
    for(answer of question.answers) {
      $('.questions').append(`
      <label>
      <input type="checkbox" name="antwort" value="${answer.text}">${answer.text}
      </label>
      <br>
      `)
    }
  }
}

document.addEventListener("DOMContentLoaded", async () => {
  if (GMDEntry.UseIngameRules) {
    document.getElementById("start_button").addEventListener("click", async () => {
      $('.question_container').fadeOut(500);
      await wait(1000);
      

        $('.task_container').fadeIn(500);
    
        var checkedboxes = [];
        var answers = [];
        quiz_right_answers = 0;
        quiz_wrong_answers = 0;
        NextQuestion();
        
        document.querySelector("#send_question").addEventListener("click", () => {    
          if (!isQuestioning) {
            return;
          }
    
          /* Es füllt den Array mit den vom Benutzer angegebenen Antworten */
          document.querySelectorAll(".questions label").forEach((question2, index) => {
            if (question2 && question2.querySelector("input").checked) {
              checkedboxes.push(index);
            }
          });
    
          /* Es füllt den Array mit den Richtigen Antworten */
          for (let answer in questions[currentQuestionIndex - 1].answers) {
            if (questions[currentQuestionIndex - 1].answers[answer].correct) {
              answers.push(parseInt(answer));
            }
          }
    
          for (let answer of questions[currentQuestionIndex - 1].answers) {
            if (AreArraysEqual(checkedboxes, answers)) {
              /* Sind alle Boxen markiert die richtig sind dann */
              quiz_right_answers++;
              currentQuestionIndex++;
              NextQuestion();
              return;
            } else {
              quiz_wrong_answers++;
              currentQuestionIndex++;
              NextQuestion();
              return;
            }
          }
        });
    });

  document.getElementById("questions_continue").addEventListener("click", async () => {
    $('.question_container').fadeOut(500);
    $('.task_container').fadeOut(500);
  });
  }
});


document.addEventListener("DOMContentLoaded", async function() {
    customElements.define("bottom-text", class extends HTMLElement {
        constructor() {
            super();
    
            let bigtitle = this.getAttribute("bigtitle");
            let littletitle = this.getAttribute("littletitle");
    
            this.innerHTML = `
            <div class="bigTitle">${bigtitle.toUpperCase()}</div>
            <div class="littleTitle">${littletitle.toUpperCase()}</div>
            `;
    }});

    customElements.define("card-bottom-text", class extends HTMLElement {
        constructor() {
            super();
    
            let bigtitle = this.getAttribute("bigtitle");
            let littletitle = this.getAttribute("littletitle");
    
            let width = this.getAttribute("width");
            let background = this.getAttribute("background");

            this.innerHTML = `
            <div class="bigTitle" style="background: ${background};-webkit-background-clip: text;">${bigtitle.toUpperCase()}</div>
            <div class="littleTitle" style="max-width: ${width};">${littletitle.toUpperCase()}</div>
            `;
    }});


    customElements.define("head-text", class extends HTMLElement {
        constructor() {
            super();
    
            let bigtitle = this.getAttribute("bigtitle");
            let littletitle = this.getAttribute("littletitle");

            this.innerHTML = `
            <div class="bigTitle">${bigtitle.toUpperCase()}</div>
            <div class="littleTitle">${littletitle.toUpperCase()}</div>
            `;
    }});



    await wait(1000);

    document.querySelectorAll(".entry_container div").forEach((entry) => {
        entry.addEventListener("click", () => {
            document.querySelector(".legal").classList.remove("active");
            document.querySelector(".illegal").classList.remove("active");
            entry.classList.add("active");
            if(entry.classList.contains("legal")) {
              document.querySelector("#einreisen").style = `background: linear-gradient(90.4deg, #5ea9ff 0.2%, rgba(30, 50, 180, 0.74) 99.85%);`;
            }
            if(entry.classList.contains("illegal")) {
              document.querySelector("#einreisen").style = `background: linear-gradient(90.4deg, #FF1A35 0.2%, rgba(161, 19, 19, 0.74) 99.85%);`;
            }
        });
    });

    document.querySelector("#einreisen").addEventListener("click", () => {
      if (GMDEntry.UseIngameRules) {
        let selected = document.querySelector(".entry_container div.active");
        let category = selected.classList.values().next().value;
        $.post("https://GMD_Entry/SelectEntryType", JSON.stringify({select: category}));
        $(".entry_container").fadeOut(500);
        $(".continue-application").fadeOut(500);
        $(".container").fadeIn(500);
        $(".question_container").fadeIn(500);
      } else {
        let selected = document.querySelector(".entry_container div.active");
        let category = selected.classList.values().next().value;
        $.post("https://GMD_Entry/SelectEntryType", JSON.stringify({select: category}));
        $(".entry_container").fadeOut(500);
        $(".continue-application").fadeOut(500);
        wait(500)
        $.post("https://GMD_Entry/NoRules", JSON.stringify({}));
      }
    });
});


function AreArraysEqual(array1, array2) {
  if (array1.length !== array2.length) {
    return false;
  }
  return array1.every((element, index) => element === array2[index]);
}

async function wait(time) {
    return new Promise(resolve => setTimeout(resolve,time))
}

$(function () {
    window.addEventListener("message", function (event) {
      var item = event.data;
      if (item.type == "enableui") {
        document.body.style.display = event.data.enable ? "grid" : "none";
        $(".wrapper").fadeIn(500);
      }
    });
});

function disconnectFunction() {
  $(".wrapper").fadeOut(1000)
  $(".container").fadeOut(1000)
  $.post(
    "https://GMD_Entry/failedQuestions",
    JSON.stringify({})
  );
}

function continueFunction() {
  $(".wrapper").fadeOut(1000)
  $(".container").fadeOut(1000)
  $.post(
    "https://GMD_Entry/SuccesQuestions",
    JSON.stringify({})
  );
}