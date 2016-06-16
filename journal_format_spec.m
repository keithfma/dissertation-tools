function spec = journal_format_spec(journal_name, spec_name)
% function [ww, hh] = get_figure_size(journal, option)
%
% Return formatting specifications for a given journal. 
%
% Arguments:
%
% journal_name = String. Journal for which formatting specifications are
%   defined, e.g. 'geology'. Omit to list all defined journals
%
% spec_name = String. Desired formatting specification, e.g.
%   'single_column_width'. Omit to list all defined options for a given journal
%
% %

% define journal specifications as map (a.k.a. python dictionary) of maps
% ...each journal is a map, with keys = spec_name

geology = containers.Map('KeyType','char','ValueType','any');
geology('page_width_cm') = 18.5;
geology('page_height_cm') = 22.5;
geology('column_width_3_column_layout_cm') = 5.9;
geology('column_width_2_column_layout_cm') = 9.1;
geology('column_spacing_cm') = 0.4233333; % 1 pica
geology('font_size_minimum') = 7;
geology('font_size_maximum') = 12;
geology('line_width_minimum') = 1;
geology('line_width_maximum') = 2;
geology('font_name') = 'Helvetica';

journal = containers.Map('KeyType','char','ValueType','any');
journal('geology') = geology;

% option: list defined journals 
if nargin == 0
    names = keys(journal);
    fprintf('\n%s: List of all defined journals\n', mfilename);
    for ii = 1:length(names)
        fprintf('\t%s\n', names{ii});
    end
    fprintf('\n');
    return
end

% validate journal name
if ~ismember(journal_name, keys(journal)) 
    error(['Invalid journal name "%s"\n', ...'
            'Run journal_format_spec() to list defined journal names.'], ...
            journal_name); 
end

% option: list all defined specifications for a given journal
if nargin == 1
    names = keys(journal(journal_name));
    fprintf('\n%s: List of all defined specifications for journal "%s"\n', ...
        mfilename, journal_name);
    for ii = 1:length(names)        
        fprintf('\t%s\n', names{ii});
    end
    fprintf('\n');
    return
end

% validate specification name
if ~ismember(spec_name, keys(journal(journal_name))) 
    error(['Invalid specification name "%s" for journal name "%s"\n', ...
           'Run journal_format_spec("%s") to see defined specification names.'], ...
           spec_name, journal_name, journal_name); 
end

% return specification value
selected_journal = journal(journal_name);
spec = selected_journal(spec_name);