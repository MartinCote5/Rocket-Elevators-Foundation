// document.addEventListener('DOMContentLoaded', ()=>{
//     document.querySelector('#submit').addEventListener('click', (e)=>{
//         let filled = true;
//         let inputs = document.querySelector('#contact form').getElementsByTagName('input');
//         let textareas = document.querySelector('#contact form').getElementsByTagName('textarea');
//         let check_ar = [1,2,3,6];
        
//         for (let i = 0; i < inputs.length; i++){
//             if(check_ar.includes(i)){
//                 if(inputs[i].value == "")
//                     filled = false;
//             }
//         };
        
//         if(textareas.item(1).value == "")
//             filled = false;

//         if(filled){
//             for (let i = 0; i < inputs.length; i++)
//                 inputs[i].value = "";
//             for (let i = 0; i < textareas.length; i++)
//                 textareas[i].value = "";
                
//             document.querySelector('#alert_success').style.display = 'block';
//             document.querySelector('#alert_mandatory').style.display = 'none';
//         }
//         else{
//             document.querySelector('#alert_success').style.display = 'none';
//             document.querySelector('#alert_mandatory').style.display = 'block';
//         }

//         e.preventDefault();
//     });
// });
