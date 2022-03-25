document.addEventListener('DOMContentLoaded', () => {
    let ctab = 'residential';
    let link = document.querySelector('#building-type').getElementsByTagName('a');

    let product_range = document.querySelector('#product_range').getElementsByTagName('input');
    var results = [{
        'number-of-floors': '',
        'number-of-basements': '',
        'number-of-apartments': ''
    }, {
        'number-of-floors': '',
        'number-of-basements': '',
        'number-of-parking-spots': '',
        'number-of-elevators': '',
        'number-of-companies': ''
    }, {
        'number-of-floors': '',
        'number-of-basements': '',
        'number-of-parking-spots': '',
        'maximum-occupancy': '',
        'number-of-corporations': ''
    }, {
        'number-of-floors': '',
        'number-of-basements': '',
        'number-of-parking-spots': '',
        'number-of-companies': '',
        'maximum-occupancy': '',
        'business-hours': ''
    }];

    for (let i = 0; i < link.length; i++)
        link[i].addEventListener('click', (e) => {
            save_data();
            document.querySelector('.ctab').classList.remove('ctab');
            e.target.classList.add("ctab");
            ctab = e.target.id;
            change_tabs();
            check_field();
            document.getElementById('buildingType').value = get_counter() + 1;
            document.getElementById('range').value = get_counter();
            e.preventDefault();
        });


    let answers = document.querySelector('#form_field').getElementsByTagName('input');
    for (var i = 0; i < answers.length; i++)
        answers.item(i).addEventListener('keyup', check_field);

    for (var i = 0; i < answers.length; i++)
        answers.item(i).addEventListener('keydown', allow_digit);

    let fieldset = document.querySelector('#product_range').getElementsByTagName('input');
    for (var i = 0; i < fieldset.length; i++)
        fieldset.item(i).addEventListener('click', check_field);

    for (var i = 0; i < product_range.length; i++)
        product_range[i].addEventListener('click', (e) => {
            if (e.target.id == "standard")
                document.getElementById("range").value = 1;
            if (e.target.id == "premium")
                document.getElementById("range").value = 2;
            if (e.target.id == "excelium")
                document.getElementById("range").value = 3;
        })


    function save_data() {
        let ar = get_fields();
        let counter = get_counter();
        const fields = document.querySelector('#form_field .row').getElementsByTagName('div');

        for (let i = 0; i < fields.length; i++) {
            if (ar.includes(i))
                results[counter][fields[i].id] = fields[i].getElementsByTagName('input')[0].value;
        };
    };

    function get_counter() {
        switch (ctab) {
            case 'residential':
                return 0;
            case 'commercial':
                return 1;
            case 'corporate':
                return 2;
            case 'hybrid':
                return 3;
        };

    }


    function calcul() {
        let answers = document.querySelector('#form_field').getElementsByTagName('input');
        let answers_dict = {};
        let quality = document.querySelector('input[name="gamme_produit"]:checked').id;


        for (var i = 0; i < answers.length; i++)
            answers_dict[answers.item(i).name] = parseInt(answers.item(i).value);

        switch (quality) {
            case 'standard':
                answers_dict["ind-price"] = 7565;
                break;
            case 'premium':
                answers_dict["ind-price"] = 12345;
                break;
            case 'excelium':
                answers_dict["ind-price"] = 15400;
        }

        document.querySelector('#elevator-unit-price input').value = '$ ' + return_commas(answers_dict["ind-price"]);

        answers_dict['building-type'] = ctab;
        fetch('https://rocketelevator.me', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(answers_dict)
        })
            .then(response => {
                return response.json();
            })
            .then(result => {
                show_results(result);
            });
    };

    function change_tabs() {
        let ar = get_fields();
        let divs = document.querySelector('#form_field').firstElementChild.getElementsByTagName('div');
        let counter = get_counter();

        for (let i = 0; i < divs.length; i++) {
            if (ar.includes(i)) {
                divs[i].style.display = 'block';
                divs[i].getElementsByTagName('input')[0].value = results[counter][divs[i].id];
            }
            else {
                divs[i].style.display = 'none';
            }

        }
    };

    function check_field() {
        let filled = true;
        let checked = false;
        let inputs = document.querySelector('#form_field').getElementsByTagName('input');
        let ar = get_fields();

        ar.forEach((i) => {
            if (inputs[i].value == "")
                filled = false;
        });

        for (let i = 0; i < product_range.length; i++) {
            if (product_range[i].checked)
                checked = true;
        }

        if (filled && checked)
            calcul();
        else
            set_zero();
    };

    function get_fields() {
        let ar = [0, 1];

        switch (ctab) {
            case 'residential':
                ar.push(2);
                break;
            case 'commercial':
                ar.push(3, 4, 5);
                break;
            case 'corporate':
                ar.push(3, 6, 7);
                break;
            case 'hybrid':
                ar.push(3, 5, 6, 8);
        }

        return ar;
    }

    function set_zero() {
        let inputs = document.querySelector('#results').getElementsByTagName('input');

        inputs[0].value = "0";
        for (let i = 1; i < inputs.length - 4; i++)
            inputs[i].value = '$ ' + return_commas(0);
    }

    function return_commas(n) {
        return n.toFixed(2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    function allow_digit(e) {
        if (e.key.length <= 1) {
            if (!/[0-9]/g.test(e.key))
                e.preventDefault();
        }
    }

    function show_results(results) {
        document.querySelector('#elevator-amount input').value = results['nbr-elevator'];
        document.querySelector('#elevator-total-price input').value = '$ ' + return_commas(results['total-elevator-price']);
        document.querySelector('#installation-fees input').value = '$ ' + return_commas(results['installation']);
        document.querySelector('#final-price input').value = '$ ' + return_commas(results['total']);
    }
});