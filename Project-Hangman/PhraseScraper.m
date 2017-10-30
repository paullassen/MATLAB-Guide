%% Web Scraper for Phrases
clear
ogSite = webread('http://www.knowyourphrase.com/');
urlEnd = extractBetween(ogSite, 'phrase-meanings/', '.html');
urlEnd = urlEnd(1:23)';
readData{1}='';
for i=1:23
    url = ['http://www.knowyourphrase.com/phrase-meanings/',urlEnd{i},'.html']
    site = webread(url);
    readData = cat(1, readData, extractBetween(site,'.html">', '</a>'));
end

%% Data processing

finalData = {''};
for i = 1:size(readData,1)
    readData{i} = replace(readData{i},'&#39;','''');
    if contains(readData{i}, 'Phrase')
    else
        finalData = cat(1, finalData, readData{i});
    end
end
phraseData = finalData(2:end)
save('phrases.mat', 'phraseData')
