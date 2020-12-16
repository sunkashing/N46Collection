import json
import os
import traceback
import urllib.request

import requests
from bs4 import BeautifulSoup as BeautifulSoup
from requests.adapters import HTTPAdapter

member_list = []
member_json = []
update_json = False


def get_member_resource():
    if update_json:
        get_member_name()
        get_member_json()
    download_official_picture()


def download_official_picture():
    if not update_json:
        with open('Nogizaka_members.json', 'r') as f:
            member_json = json.load(fp=f)
    for member in member_json:
        member_val = list(member.values())[1]
        print(member_val['picture_name'])
        file_name = member_val['picture_name']
        dir_path = os.path.dirname(os.path.realpath(__file__))
        file_path = os.path.join(dir_path, file_name)

        if not download_one_file(member_val['picture_url'], file_path):
            continue


def get_member_name():
    with open('nogizaka_member_list.txt') as f:
        lines = f.read().splitlines()
    filtered_lines = list(filter(lambda line: line, lines))
    for line in filtered_lines:
        line = line.strip()
        pair = line.split(" ")
        member_list.append(pair[1])


def get_member_json():
    for member in member_list:
        url = 'http://www.nogizaka46.com/member/detail/' + member + '.php'
        req = urllib.request.Request(url, headers={'User-Agent': "Magic Browser"})
        resp = urllib.request.urlopen(req)
        html = resp.read()
        bs = BeautifulSoup(html, "html.parser")
        member_dict = {}
        member_dict['member_name'] = member
        member_dict['member_info'] = {}
        member_dict['member_info']['picture_name'] = member + '.jpg'

        get_member_picture_url(bs, member_dict)
        get_member_infos(bs, member_dict)
        get_member_status(bs, member_dict)
        print(member_dict)
        member_json.append(member_dict)

    with open('Nogizaka_members.json', 'w') as f:
        json.dump(member_json, f, indent=4, ensure_ascii=False)


def get_member_picture_url(bs, member_dict):
    member_picture_url = bs.find('div', id='profile').img.attrs['src']
    member_dict['member_info']['picture_url'] = member_picture_url


def get_member_infos(bs, member_dict):
    member_hiragana_name = bs.find_all('div', class_='txt')[0].h2.span.get_text()
    member_kanji_name = bs.find_all('div', class_='txt')[0].h2.get_text()
    member_kanji_name = member_kanji_name.replace(member_hiragana_name, '').strip(' ')
    member_dict['member_info']['infos'] = {}
    member_dict['member_info']['infos']['kanji_name'] = member_kanji_name
    member_dict['member_info']['infos']['hiragana_name'] = member_hiragana_name

    member_infos_keys = bs.find_all('div', class_='txt')[0].dl.find_all('dt')
    member_infos_values = bs.find_all('div', class_='txt')[0].dl.find_all('dd')
    for info in member_infos_keys:
        if info.get_text() == '生年月日：':
            member_dict['member_info']['infos']['birthday'] = member_infos_values[0].get_text()
        elif info.get_text() == '血液型：':
            member_dict['member_info']['infos']['blood_type'] = member_infos_values[1].get_text()
        elif info.get_text() == '星座：':
            member_dict['member_info']['infos']['constellation'] = member_infos_values[2].get_text()
        elif info.get_text() == '身長：':
            member_dict['member_info']['infos']['height'] = member_infos_values[3].get_text()


def get_member_status(bs, member_dict):
    member_status = bs.find_all('div', class_='status')[0].find_all('div')
    member_dict['member_info']['status'] = []
    for status in member_status:
        member_dict['member_info']['status'].append(status.get_text())


def download_one_file(url, file_path):
    """下载单个文件(图片/视频)"""
    try:
        if not os.path.isfile(file_path):
            s = requests.Session()
            s.mount(url, HTTPAdapter(max_retries=5))
            downloaded = s.get(url, timeout=(5, 10))
            with open(file_path, 'wb') as f:
                f.write(downloaded.content)
    except Exception as e:
        print('Error: ', e)
        traceback.print_exc()
        return False
    return True


if __name__ == "__main__":
    get_member_resource()
