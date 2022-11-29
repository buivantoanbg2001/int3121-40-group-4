

export function gen_user_id(name: string): string {
    let rand_num = Math.floor(Math.random() * 10000) + 1;
    let num_id = rand_num.toString();
    if (num_id.length === 1) {
        num_id = "000" + num_id;
    }
    else if (num_id.length === 2) {
        num_id = "00" + num_id;
    }
    else if (num_id.length === 3) { 
        num_id = "0" + num_id;
    }
    let user_id = name + num_id; 
    return user_id;
}