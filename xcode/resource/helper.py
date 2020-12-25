import json
import os
import traceback
import urllib.request
import re

import requests
from bs4 import BeautifulSoup as BeautifulSoup
from requests.adapters import HTTPAdapter

dir_path = os.path.dirname(os.path.realpath(__file__))
song_json = []
num_single = 25

def get_song_json():
    get_single_json()



def get_single_json():
    # single_json = []
    for i in range(num_single):
        url = 'http://skymotors.boy.jp/n46/cd/single' + str(i + 1).zfill(3) + '.html'
        req = urllib.request.Request(url, headers={'User-Agent': "Magic Browser"})
        resp = urllib.request.urlopen(req)
        html = resp.read()
        bs = BeautifulSoup(html, "html.parser")
        single_dict = {}
        meta = bs.find_all('font')[0].get_text().split("「")
        year = bs.body.contents[9].split("。")[1]
        i = year.index("日")
        year = year[:i + 1]
        res = re.sub('[^0-9]', '/', year).split('/')
        res = str(res[0]).zfill(4) + '/' + str(res[1]).zfill(2) + '/' + str(res[2]).zfill(2)
        single_dict['type'] = 'シングル'
        single_dict['title'] = meta[1][:-1]
        single_dict['order'] = int("".join(filter(str.isdigit, meta[0])))
        single_dict['release_date'] = res

        single_dict['cover_name'] = []
        single_dict['cover_url'] = []

        for img in bs.find_all('img'):
            u = img.attrs['src']
            if '.jpg' in u:
                cover_url = 'http://skymotors.boy.jp/n46' + u[2:]
                single_dict['cover_url'].append(cover_url)

                cover_name = u[u.rindex('/') + 1:]
                single_dict['cover_name'].append(cover_name[:-4])

                cover_path = os.path.join(dir_path, cover_name)
                # if not download_one_file(cover_url, cover_path):
                #     continue

        single_dict['center'] = []
        single_dict['fukujin'] = []
        single_dict['senbatsu'] = []
        single_dict['under'] = []

        for member in bs.find_all('table')[1].find_all('tr'):
            z = member.contents
            if len(z) == 2:
                member_name = z[0].get_text()
                level = z[1].img.attrs['src']
                if 'center' in level:
                    single_dict['center'].append(member_name)
                elif 'fukujin' in level:
                    single_dict['fukujin'].append(member_name)
                elif 'senbatsu' in level:
                    single_dict['senbatsu'].append(member_name)
                elif 'under' in level:
                    single_dict['under'].append(member_name)

        single_dict['songs'] = []
        for song in bs.find_all('table'):
            song_dict = {}
            if 'rules' in song.attrs and song.attrs['rules'] == 'none' and 'border' in song.attrs and song.attrs['border'] == '2':
                for tr in song.find_all('tr'):
                    for td in tr.find_all('td'):
                        if 'width' in td.attrs:
                            song_dict['song_name'] = td.get_text()
                            print(song_dict['song_name'])
                            break
                        elif 'colspan' in td.attrs and td.attrs['colspan'] == '5':
                            song_dict['song_center'] = []
                            song_dict['song_members'] = []

                            song_center = td.div.contents[0]

                            for ele in td.div.contents:
                                if '<br/>' in ele:
                                    continue
                                # ele = ele.replace('\n', '')
                                if 'センター' in song_center:
                                    # print(song_center)
                                    l = song_center.rindex('：')
                                    r = song_center.rindex('）')
                                    song_center = song_center[l + 1:r].split('、')
                                    song_dict['song_center'] = song_center

                                elif isinstance(ele, str) and ele:
                                    # print(ele)
                                    ele = ele.replace('\n', '').split('：')[-1].strip().split('、')
                                    for e in ele:
                                        if e:
                                            song_dict['song_members'].append(e)
                
            if song_dict:
                single_dict['songs'].append(song_dict)
        song_json.append(single_dict)

    # song_json.append(single_json)

    with open('nogizaka_songs.json', 'w') as f:
        json.dump(song_json, f, indent=4, ensure_ascii=False)




member_list = []
member_json = []
update_json = True


def get_member_resource():
    if update_json:
        get_member_name()
        get_member_json()
    # download_official_picture()


def download_official_picture():
    if not update_json:
        with open('nogizaka_members.json', 'r') as f:
            member_json = json.load(fp=f)
    for member in member_json:
        member_val = list(member.values())[1]
        print(member_val['picture_name'])
        file_name = member_val['picture_name']
        dir_path = os.path.dirname(os.path.realpath(__file__))
        file_path = os.path.join(dir_path, file_name)

        # if not download_one_file(member_val['picture_url'], file_path):
        #     continue


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
        print(url)
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
            res = re.sub('[^0-9]', '/', member_infos_values[0].get_text()).split('/')
            birthday = str(res[0]).zfill(4) + '/' + str(res[1]).zfill(2) + '/' + str(res[2]).zfill(2)

            member_dict['member_info']['infos']['birthday'] = birthday
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
    # get_member_resource()
    get_song_json()
