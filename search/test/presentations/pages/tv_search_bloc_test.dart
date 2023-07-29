import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/entities/tv.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTVBloc searchTVBloc;
  late MockSearchTv mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTv();
    searchTVBloc = SearchTVBloc(mockSearchTV);
  });

  final tv = Tv(
      backdropPath: "/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg",
      genreIds: const [10765, 10759, 18],
      id: 84773,
      name: "The Lord of the Rings: The Rings of Power",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "The Lord of the Rings: The Rings of Power",
      overview:
          "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
      popularity: 5975.998,
      posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
      voteAverage: 7.6,
      voteCount: 593);

  final tvList = <Tv>[tv];
  const tQuery = 'the lord';

  group('search TV Series', () {
    blocTest<SearchTVBloc, SearchState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockSearchTV.execute(tQuery))
            .thenAnswer((_) async => Right(tvList));
        return searchTVBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHashDataTV(tvList),
      ],
      verify: (bloc) => verify(
        mockSearchTV.execute(tQuery),
      ),
    );

    blocTest<SearchTVBloc, SearchState>(
      'should return failure message when data is unsuccessful',
      build: () {
        when(mockSearchTV.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTVBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) => verify(
        mockSearchTV.execute(tQuery),
      ),
    );
  });
}
