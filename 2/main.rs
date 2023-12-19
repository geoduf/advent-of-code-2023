use regex::Regex;
use std::fs;

fn get_fewest_number(line: &str, color: &str) -> i64 {
    let re_string = format!(r"(\d+) {}", color);
    let re = Regex::new(&re_string).unwrap();
    let mut max = 0;
    for (_, [count]) in re.captures_iter(line).map(|c| c.extract()) {
        let count_int = count.parse::<i64>().unwrap();
        if max < count_int {
            max = count_int;
        }
    }
    return max;
}

fn is_color_ok(line: &str, color: &str) -> bool {
    let re_string = format!(r"(\d+) {}", color);
    let re = Regex::new(&re_string).unwrap();
    for (_, [count]) in re.captures_iter(line).map(|c| c.extract()) {
        let count_int = count.parse::<i64>().unwrap();
        let ok = match color {
            "red" => count_int <= 12,
            "green" => count_int <= 13,
            "blue" => count_int <= 14,
            _ => false,
        };
        if !ok {
            return false;
        }
    }
    return true;
}

fn main() {
    let file_content = fs::read_to_string("input.txt").expect("Error reading file");
    let lines = file_content.split("\n");
    let re_game = Regex::new(r"(Game (\d+):)").unwrap();
    let mut ids_sum = 0;
    let mut power = 0;
    for line in lines {
        if line == "" {
            continue;
        }
        let game_match_and_number = re_game.captures(line).unwrap();
        let game_number = game_match_and_number.get(2).unwrap().as_str();

        let ok =
            is_color_ok(line, "red") && is_color_ok(line, "green") && is_color_ok(line, "blue");

        let i = get_fewest_number(line, "red")
            * get_fewest_number(line, "green")
            * get_fewest_number(line, "blue");
        power += i;

        if ok {
            ids_sum += game_number.parse::<i64>().unwrap();
        }
    }
    println!(" result sum ids => {}", ids_sum);
    println!(" result power => {}", power);
}
